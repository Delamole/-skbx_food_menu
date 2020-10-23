//
//  AddressForFoodTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 15.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class AddressForFoodTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: Adres) {
        
        nameLabel.text = item.name
        adressLabel.text = item.address
   
    }

}
