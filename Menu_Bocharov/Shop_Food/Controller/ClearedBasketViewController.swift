//
//  ClearedBasketViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 01.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class ClearedBasketViewController: UIViewController {

    @IBOutlet weak var returnButton: AcceptButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var upConstr: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upConstr.constant = 0.3 * view.bounds.height
        
        view.backgroundColor = .clear
        mainView.layer.cornerRadius = 15
        
        returnButton.backgroundColor = activButtonColor

        // Do any additional setup after loading the view.
    }
    

    @IBAction func returnAction(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        self.dismissTo(vc: nil, count: 5, animated: true)
    }


}
