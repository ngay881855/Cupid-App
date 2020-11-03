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
    func didSwipeRight(person: Person)
}

class PersonView: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var panGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet private weak var tabBar: UITabBar!
    @IBOutlet private weak var personTabBarItem: UITabBarItem!
    @IBOutlet private weak var birthdayTabBarItem: UITabBarItem!
    @IBOutlet private weak var locationTabBarItem: UITabBarItem!
    @IBOutlet private weak var phoneTabBarItem: UITabBarItem!
    @IBOutlet private weak var lockTabBarItem: UITabBarItem!
    
    private var _person: Person?
    private var personDetailViews: [String: UIView] = [:]
    @IBOutlet private weak var personDetailView: UIView!
    
    var person: Person {
        return self._person ?? Person()
    }
    
    // MARK: - Public properties
    weak var delegate: PersonViewDelegate?
    
    var originalPoint = CGPoint()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    /*
     * Initializing View
     */

    func configUIData(with person: Person) {
        self._person = person
        
        self.tabBar.selectedItem = personTabBarItem
        self.setTabIconsAlignment()
        self.initializeDetailViews()
        
        if let view = self.personDetailViews[ProfileView.reuseIdentifier] {
            self.personDetailView.bringSubviewToFront(view)
        }
    }
    
    private func setTabIconsAlignment() {
        self.locationTabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        self.phoneTabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
        self.lockTabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 5, right: 0)
    }
    
    private func initializeDetailViews() {
        if let profileView = UIView.viewFromNibName(ProfileView.reuseIdentifier) as? ProfileView {
            profileView.configUIData(with: self.person)
            profileView.frame = self.personDetailView.bounds
            self.personDetailViews[ProfileView.reuseIdentifier] = profileView
            self.personDetailView.addSubview(profileView)
        }
        if let birthdayView = UIView.viewFromNibName(BirthdayView.reuseIdentifier) as? BirthdayView {
            birthdayView.configUIData(with: self.person)
            birthdayView.frame = self.personDetailView.bounds
            self.personDetailViews[BirthdayView.reuseIdentifier] = birthdayView
            self.personDetailView.addSubview(birthdayView)
        }
        if let locationView = UIView.viewFromNibName(LocationView.reuseIdentifier) as? LocationView {
            locationView.configUIData(withPerson: self.person)
            locationView.frame = self.personDetailView.bounds
            self.personDetailViews[LocationView.reuseIdentifier] = locationView
            self.personDetailView.addSubview(locationView)
        }
        if let phoneView = UIView.viewFromNibName(PhoneView.reuseIdentifier) as? PhoneView {
            phoneView.configUIData(with: self.person)
            phoneView.frame = self.personDetailView.bounds
            self.personDetailViews[PhoneView.reuseIdentifier] = phoneView
            self.personDetailView.addSubview(phoneView)
        }
        
        if let lockView = UIView.viewFromNibName(LockView.reuseIdentifier) as? LockView {
            lockView.configUIData(with: self.person)
            lockView.frame = self.personDetailView.bounds
            self.personDetailViews[LockView.reuseIdentifier] = lockView
            self.personDetailView.addSubview(lockView)
        }
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
    
    func performSwipeRightAction() {
        let personView = self
        let moveDestination = CGPoint(x: personView.originalPoint.x + personView.bounds.width + personView.bounds.width / 2, y: personView.originalPoint.y + personView.bounds.height)
        
        UIView.animate(
            withDuration: 0.25) { personView.center = moveDestination } completion: { _ in
            self.performSwipeCompletion(swipeAction: .right)
        }
    }
    
    private func performSwipeCompletion(swipeAction: SwipeAction) {
        switch swipeAction {
        case .left:
            self.delegate?.didSwipeLeft()
            
        case .right:
            self.delegate?.didSwipeRight(person: person)
            
        case .none:
            break
        }
    }
}

extension PersonView: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        var tempView: UIView?
        switch item.tag {
        case 0: // ProfileView
            tempView = self.personDetailViews[ProfileView.reuseIdentifier]
        
        case 1: // BirthdayView
            tempView = self.personDetailViews[BirthdayView.reuseIdentifier]
            
        case 2: // LocationView
            tempView = self.personDetailViews[LocationView.reuseIdentifier]
            
        case 3: // PhoneView
            tempView = self.personDetailViews[PhoneView.reuseIdentifier]
            
        case 4:
            tempView = self.personDetailViews[LockView.reuseIdentifier]
            
        default:
            break
        }
        
        guard let view = tempView else {
            print("Error tabBar(_ tabBar: UITabBar, didSelect")
            return }
        self.personDetailView.bringSubviewToFront(view)
    }
}
