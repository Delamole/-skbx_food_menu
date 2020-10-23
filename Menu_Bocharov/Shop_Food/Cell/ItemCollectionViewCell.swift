//
//  ItemCollectionViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 23.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imageItem: UIImageView!
    
    @IBOutlet weak var weightItem: UILabel!
    @IBOutlet weak var priceItem: UILabel!
    @IBOutlet weak var descrItem: UILabel!
}
