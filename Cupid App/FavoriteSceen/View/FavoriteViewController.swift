//
//  FavoriteViewController.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/26/20.
//

import UIKit

extension Notification.Name {
    public static let myNotificationKey = Notification.Name(rawValue: "myNotificationKey")
}

class FavoriteViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var favoriteViewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        
        favoriteViewModel.delegate = self
    }
    
    private func setupUI() {
        self.title = "Favorite People"
        self.tableView.tableFooterView = UIView()
    }
    
    @objc func addPersonToFavoriteList(_ notification: Notification) {
        guard let person = notification.userInfo?["person"] as? Person else { return }
        favoriteViewModel.addPerson(person: person)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        favoriteViewModel.cellForRowAt(indexPath: indexPath, tableView: tableView)
    }
}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}
