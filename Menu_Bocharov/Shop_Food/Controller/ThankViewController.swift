//
//  ThankViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 07.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit
import GoogleMaps

class ThankViewController: UIViewController {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var thankButton: UIButton!
    
//    var id_order = 0
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismissTo(vc: nil, count: 5, animated: true)
    }
    
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        upConstr.constant = 0.6 * view.bounds.height
        mainView.layer.cornerRadius = 15
        LoadModel.shared.sendBusket { (data) in answer = data.data
            self.orderLabel.text = "Благодарим за заказ N \(answer!.id)!"
            print("answer_id \(answer?.id)")
        }
        thankButton.backgroundColor = activButtonColor
        thankButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    


}
