//
//  BirthdayView.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/28/20.
//

import UIKit

class BirthdayView: UIView {

    @IBOutlet private weak var datePicker: UIDatePicker!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    func configUIData(with person: Person) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateTimeStr = person.dateOfBirth?.date else { return }
        let subStringLastIndex = dateTimeStr.index(dateTimeStr.startIndex, offsetBy: 9)
        let dateStr = dateTimeStr[...subStringLastIndex]
        guard let date = dateFormatter.date(from: String(dateStr)) else { return }
        datePicker.date = date
        
        datePicker.isUserInteractionEnabled = false
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
        }
    }
}
