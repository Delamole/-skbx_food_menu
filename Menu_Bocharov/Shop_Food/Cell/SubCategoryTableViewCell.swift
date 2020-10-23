//
//  SubCategoryTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 17.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameSubCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: SubCategory) {
        if item.is_category == true {
          nameSubCategoryLabel.text = item.name
        }
      }

}
