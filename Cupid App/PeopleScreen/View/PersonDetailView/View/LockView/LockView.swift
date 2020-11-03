//
//  LockView.swift
//  Cupid App
//
//  Created by Ngay Vong on 11/3/20.
//

import UIKit

class LockView: UIView {

    @IBOutlet private weak var unavailableMessageLabel: UILabel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configUIData(with person: Person) {
        self.unavailableMessageLabel.text = "Please subscribe to use this service!"
    }
}
