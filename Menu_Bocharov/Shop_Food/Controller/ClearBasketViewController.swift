//
//  ClearBasketViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 01.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class ClearBasketViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    
    
    @IBOutlet weak var clearButton: AcceptButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upConstr.constant = 0.6 * view.bounds.height
        
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        clearButton.backgroundColor = activButtonColor

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearAction(_ sender: Any) {
        myBasket.prods.removeAll()
        myBasket.price = 0
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
