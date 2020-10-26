//
//  FavoriteViewModel.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/26/20.
//

import Foundation

protocol FavoriteViewModelDelegate: AnyObject {
}

class FavoriteViewModel {
    
    var dataSource: [Person] = []
    
    weak var delegate: FavoriteViewModelDelegate?
    
    func addPerson(person: Person) {
        dataSource.append(person)
    }
}
