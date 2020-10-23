//
//  HistoryPromoTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 31.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class HistoryPromoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var downView: UIView!
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var mainView: UIView!
    
  
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var descriptionPromo: UILabel!
    @IBOutlet weak var namePromo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        namePromo.textColor = UIColor(hexString: "#8A8A8D", alpha: 1)
        timeLabel.textColor = UIColor(hexString: "#8A8A8D", alpha: 1)
        
        
        contentView.dropShadow(color: .red, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
       

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initCell(item: Promos)  {
        namePromo.text = item.code
        descriptionPromo.text = item.description
        
        print("\(item.date_activation)")
        
        let dateFormatter = DateFormatter()
        let sub = item.date_activation.substring(to: 19)
        print("\(sub)")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: sub)
        print(date)
        
        let interval = Int((item.validity-Int(date!.timeIntervalSinceNow)) / 3600 )
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)]
        let attributedString = NSMutableAttributedString(string: interval.days(), attributes: attrs)
        let normalString = NSMutableAttributedString(string: "Истекает через: ")
        normalString.append(attributedString)
        timeLabel.attributedText = normalString
        
//        timeLabel.text = "Истекает через: \(interval.days())"
    
        if item.used == true {
        icon.image = UIImage(named: "soonfinishPromo")
        } else{
            icon.image = UIImage(named: "activPromo")
        }
    }
}
