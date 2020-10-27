//
//  CupidAppViewController.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/25/20.
//

import UIKit

class CupidAppViewController: UIViewController {

    @IBOutlet private weak var cardsContentView: UIView!
    @IBOutlet private weak var loadDataActivityIndicator: UIActivityIndicatorView!
    
    var model: CupidViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Cupid App"
        
        model = CupidViewModel()
        model?.delegate = self
        model?.reloadData()
        
        setupNotificationForFavoriteViewController()
    }
    
    private func setupNotificationForFavoriteViewController() {
        if let viewControllers = self.tabBarController?.viewControllers {
            for navigationViewController in viewControllers {
                if let favoriteViewController = navigationViewController.children.first as? FavoriteViewController {
                    NotificationCenter.default.addObserver(favoriteViewController, selector: #selector(favoriteViewController.addPersonToFavoriteList(_:)), name: .myNotificationKey, object: nil)
                }
            }
        }
    }
    
    @IBAction private func reloadData(_ sender: Any) {
        model?.reloadData()
    }
    
    @IBAction private func addFavorite(_ sender: Any) {
        model?.addToFavorite()
    }
}

extension CupidAppViewController: CupidViewModelDelegate {
    func addPersonToFavoriteList(person: Person) {
        let userInfo = ["person": person]
        NotificationCenter.default.post(name: .myNotificationKey, object: nil, userInfo: userInfo)
    }
    
    func startActivityIndicator() {
        self.loadDataActivityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.loadDataActivityIndicator.stopAnimating()
    }

    var bounds: CGRect {
        return self.cardsContentView.bounds
    }
    
    func addView(with view: PersonView) {
        self.cardsContentView.insertSubview(view, at: 0)
    }
    
    func removeView(_ view: PersonView) {
        view.removeFromSuperview()
    }
    
    func failed(error: CustomError) {
        print(error)
    }
}
