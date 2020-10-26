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
    var favoriteViewModel: FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Cupid App"
        
        model = CupidViewModel()
        model?.delegate = self
        model?.reloadData()
        
        favoriteViewModel = FavoriteViewModel()
        favoriteViewModel?.delegate = self
    }
    
    @IBAction private func reloadData(_ sender: Any) {
        model?.reloadData()
    }
}

extension CupidAppViewController: CupidViewModelDelegate {
    func addPersonToFavoriteList(person: Person) {
        self.favoriteViewModel?.addPerson(person: person)
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

extension CupidAppViewController: FavoriteViewModelDelegate {
}
