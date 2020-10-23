//
//  BasketTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 29.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: TableProductBasket) {
        nameProduct.text = item.name
        priceProduct.text = "\(item.price) руб"
        countLabel.text = "\(item.count)x"
      }

}
