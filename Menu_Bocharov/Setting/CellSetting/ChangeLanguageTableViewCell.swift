//
//  ChangeLanguageTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 13.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class ChangeLanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var chooseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: Language, setLanguage: String) {
           languageLabel.text = item.name
           
           if (item.name == setLanguage){
                chooseButton.setBackgroundImage(UIImage(named: "greenButton"), for: .normal)
               } else{
                chooseButton.setBackgroundImage(UIImage(named: "grayButton"), for: .normal)
            }
       }

}
