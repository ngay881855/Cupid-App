//
//  ProfileView.swift
//  Cupid App
//
//  Created by Ngay Vong on 11/2/20.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    func configUIData(with person: Person) {
        
        self.imageView.layer.cornerRadius = 10
        
        guard let url = URL(string: person.picture?.large ?? "") else {
            return
        }
        self.fullNameLabel.text = person.fullName
        self.imageView.sd_setImage(with: url, completed: nil)
    }
}
