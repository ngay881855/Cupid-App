//
//  PersonView.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/26/20.
//

import SDWebImage
import UIKit

enum SwipeAction: Int {
    case left = -1
    case right = 1
    case none = 0
}

protocol PersonViewDelegate: AnyObject {
    func didSwipeLeft()
    func didSwipeRight()
}

class PersonView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var panGestureRecognizer: UIPanGestureRecognizer!
    
    // MARK: - Public properties
    weak var delegate: PersonViewDelegate?
    
    var originalPoint = CGPoint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
     * Initializing View
     */
    private func setupView() {
        layer.cornerRadius = bounds.width / 20
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0.5, height: 3)
        layer.shadowColor = UIColor.darkGray.cgColor
        clipsToBounds = true
        backgroundColor = .white
    }
    
    func configUIData(with person: Person) {
        guard let url = URL(string: person.picture?.large ?? "") else {
            return
        }
        self.fullNameLabel.text = person.fullName
        self.imageView.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction private func panGestureBeingDragged(_ sender: Any) {
        guard let gestureRecognizer = sender as? UIPanGestureRecognizer, let personView = gestureRecognizer.view else {
            return
        }
        let translation = gestureRecognizer.translation(in: personView.superview)
        var swipeAction: SwipeAction = .none
        
        switch self.panGestureRecognizer.state {
        // Keep swiping
        case .began:
            originalPoint = personView.center
        //in the middle of a swipe
        case .changed:
            personView.center = CGPoint(x: originalPoint.x + translation.x, y: originalPoint.y + translation.y)
            
        // swipe ended
        case .ended:
            let moveRangeVertical = self.bounds.height / 2
            var moveDestination = CGPoint(x: self.originalPoint.x, y: self.originalPoint.y + moveRangeVertical)
            let moveRangeHorizontal = self.bounds.width / 2
            // SwipeRight
            if personView.center.x > self.originalPoint.x + moveRangeHorizontal {
                moveDestination.x = self.originalPoint.x + self.bounds.width
                swipeAction = .right
            } else if personView.center.x < self.originalPoint.x - moveRangeHorizontal {
                moveDestination.x = self.originalPoint.x - self.bounds.width
                swipeAction = .left
            } else {
                moveDestination = self.originalPoint
            }
            
            UIView.animate(
                withDuration: 0.25) { personView.center = moveDestination } completion: { _ in
                self.performSwipeCompletion(swipeAction: swipeAction)
            }
            
        case .possible, .cancelled, .failed:
            break
            
        @unknown default:
            fatalError("Wrong gesture state")
        }
    }
    
    private func performSwipeCompletion(swipeAction: SwipeAction) {
        switch swipeAction {
        
        case .left:
            self.delegate?.didSwipeLeft()
            
        case .right:
            self.delegate?.didSwipeRight()
            
        case .none:
            break
        }
    }
}
