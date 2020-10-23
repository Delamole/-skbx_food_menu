//
//  SettingTableViewCell.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 13.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit


protocol SetSwitchSettingDelegate {
    func change(isOn: Bool, name: String)
}

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameSettingLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var imageArrow: UIImageView!
    @IBOutlet weak var switchSetting: UISwitch!
    
    var delegate:SetSwitchSettingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(item: Setting) {
        
        imageArrow.isHidden = item.arrowSetting
        languageLabel.isHidden = item.language
        languageLabel.text = item.languageText
        nameSettingLabel.text = item.nameSettring
        switchSetting.isHidden = item.switchSetting
        switchSetting.isOn = item.switchIsOn
        switchSetting.accessibilityIdentifier = item.nameSettring
        switchSetting.addTarget(self, action: #selector(self.switchChange(_ :)), for: .valueChanged)
    }

    @objc func switchChange(_ sender: UISwitch) {
//        print("Switch tag \(sender.accessibilityIdentifier!)")
//        print("Switch is On \(sender.isOn)")
        delegate?.change(isOn: sender.isOn, name: sender.accessibilityIdentifier!)
    }
}
