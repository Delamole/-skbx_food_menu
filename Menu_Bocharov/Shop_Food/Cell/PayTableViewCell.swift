//
//  PayTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 07.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class PayTableViewCell: UITableViewCell {

    @IBOutlet weak var ckeck: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: PayMethod) {
        ckeck.image =  UIImage(named: item.check)
        icon.image =  UIImage(named: item.icon)
        name.text = item.name
      }

}
