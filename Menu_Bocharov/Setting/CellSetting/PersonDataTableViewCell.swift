//
//  PersonDataTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 15.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class PersonDataTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowImage: UIImageView!
   
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var personIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: PersonData) {
        arrowImage.isHidden = item.arrowImage
        personIcon.isHidden = item.iconPerson
           
        if (item.namePersonData == ""){
            dataLabel.text = item.placeHolderPersonData
            dataLabel.textColor = .gray
            } else{
                dataLabel.text = item.namePersonData
            }
       }

}
