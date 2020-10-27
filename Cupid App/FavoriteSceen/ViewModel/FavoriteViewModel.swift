//
//  FavoriteViewModel.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/26/20.
//

import Foundation
import UIKit

protocol FavoriteViewModelDelegate: AnyObject {
    func reloadTableView()
}

class FavoriteViewModel {
    
    var dataSource: [Person] = [] {
        didSet {
            self.delegate?.reloadTableView()
        }
    }
    
    weak var delegate: FavoriteViewModelDelegate?
    
    func addPerson(person: Person) {
        dataSource.append(person)
    }
    
    func numberOfRows() -> Int {
        return dataSource.count
    }
    
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePersonTableViewCell.reuseIdentifier, for: indexPath) as? FavoritePersonTableViewCell else {
            fatalError("Can not dequeue cell")
        }
        
        cell.configUIDate(person: dataSource[indexPath.row])
        return cell
    }
}
