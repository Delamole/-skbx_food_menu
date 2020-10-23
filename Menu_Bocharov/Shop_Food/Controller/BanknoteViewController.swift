//
//  BanknoteViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 07.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

protocol GetChargeProtocolDelegate {
    func getCharge(charge: Int)
}

class BanknoteViewController: UIViewController {
    
    
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var button5000: UIButton!
    @IBOutlet weak var button100: UIButton!
    
    var delegate: GetChargeProtocolDelegate?
    
    @IBAction func action1(_ sender: Any) {
        delegate?.getCharge(charge: 1000)
        myBasket.comment.banknote = 1000
        dismiss(animated: true, completion: nil)
    }
    @IBAction func action2(_ sender: Any) {
        delegate?.getCharge(charge: 5000)
        myBasket.comment.banknote = 5000
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upConstr.constant = 0.6 * view.bounds.height
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        button100.layer.cornerRadius = 15
        button5000.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    

}
