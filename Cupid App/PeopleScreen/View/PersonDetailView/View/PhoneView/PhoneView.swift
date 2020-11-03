//
//  PhoneView.swift
//  Cupid App
//
//  Created by Ngay Vong on 11/3/20.
//

import UIKit

class PhoneView: UIView {

    @IBOutlet private weak var mobileLabel: UILabel!
    @IBOutlet private weak var cellPhoneLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configUIData(with person: Person) {
        self.mobileLabel.text = "Mobile: \(person.phone ?? "")"
        self.cellPhoneLabel.text = "Cell: \(person.cell ?? "")"
    }
}
