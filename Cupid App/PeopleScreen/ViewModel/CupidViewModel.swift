//
//  CupidViewModel.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/25/20.
//

import Foundation
import UIKit

protocol CupidViewModelDelegate: AnyObject {
    var bounds: CGRect { get }
    
    func failed(error: CustomError)
    
    func addView(with view: PersonView)
    
    func removeView(_ view: PersonView)
    
    func startActivityIndicator()
    
    func stopActivityIndicator()
}

class CupidViewModel {
    
    // MARK: - Private properties
    
    weak private var delegate: CupidViewModelDelegate?
    
    private var dataSource: [Person] = []
    private var listPersonViews: [PersonView] = [] {
        didSet {
            DispatchQueue.main.async {
                if self.listPersonViews.count < 3 {
                    self.addNewPersonFromDataSource()
                }
            }
        }
    }
    
    required init(delegate: CupidViewModelDelegate) { //, containerDelegate: ) {
        self.delegate = delegate
    }
    
    func reloadData() {
        self.delegate?.startActivityIndicator()
        dataSource.removeAll()
        fetchUsers()
        while !listPersonViews.isEmpty {
            removePersonView()
        }
        self.delegate?.stopActivityIndicator()
    }
    
    private func fetchUsers() {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else { return }
        
        NetworkManager.manager.request(ApiResponse.self, withRequest: url) { result in
            switch result {
            case .success(let response):
                if let people = response.results {
                    DispatchQueue.main.async {
                        self.dataSource = people
                        self.addNewPersonFromDataSource()
                    }
                } else {
                    self.delegate?.failed(error: CustomError.decodingFailed)
                }
                
            case .failure(let error):
                self.delegate?.failed(error: error)
            }
        }
    }
    
    private func addViewToController(with view: PersonView) {
        self.delegate?.addView(with: view)
    }
    
    private func addNewPersonFromDataSource() {
        if dataSource.isEmpty {
            self.fetchUsers()
        } else {
            let person = dataSource.removeLast()
            guard let personView = self.createPersonView(with: person, delegate: self) else { return }
            listPersonViews.insert(personView, at: 0)
            addViewToController(with: personView)
        }
    }
    
    private func createPersonView(with person: Person, delegate: PersonViewDelegate) -> PersonView? {
        guard let bounds = self.delegate?.bounds,
              let personView = UIView.viewFromNibName(PersonView.reuseIdentifier) as? PersonView else {
            return nil
        }
        
        personView.delegate = delegate
        personView.frame = bounds
        personView.backgroundColor = .white
        personView.configUIData(with: person)
        return personView
    }
    
    private func removePersonView() {
        guard !self.listPersonViews.isEmpty else { return }
        let view = listPersonViews.removeLast()
        self.delegate?.removeView(view)
    }
}

extension CupidViewModel: PersonViewDelegate {
    func didSwipeLeft() {
        self.removePersonView()
    }
    
    func didSwipeRight() {
        // add to favorite
        print("add to favorite")
    }
}
