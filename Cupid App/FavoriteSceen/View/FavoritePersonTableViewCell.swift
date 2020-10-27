//
//  FavoritePersonTableViewCell.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/26/20.
//

import UIKit

class FavoritePersonTableViewCell: UITableViewCell {

    @IBOutlet private weak var personImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUIDate(person: Person) {
        personImageView.layer.cornerRadius = personImageView.frame.width / 2
        
        guard let url = URL(string: person.picture?.medium ?? "") else {
            return
        }
        self.fullNameLabel.text = person.fullName
        self.personImageView.sd_setImage(with: url, completed: nil)
        self.addressLabel.text = person.address
        self.ageLabel.text = person.age
    }
}
