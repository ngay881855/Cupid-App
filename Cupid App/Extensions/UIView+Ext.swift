//
//  UIView+Ext.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/26/20.
//

import Foundation
import UIKit

extension UIView {
    class func viewFromNibName(_ name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: self, options: nil)
        return views?.first as? UIView
    }
}

extension UIView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UIView {
    func setupView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .white
    }
}
