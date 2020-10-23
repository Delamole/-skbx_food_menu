//
//  EnterCreditViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 14.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

protocol EnterCreditDelegate{
    func updateCredit(credit: Int)
}

class EnterCreditViewController: UIViewController {
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var creditTextfield: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var delegate: EnterCreditDelegate?
    var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        errorLabel.isHidden = true
        view.backgroundColor = .clear
        mainview.layer.cornerRadius = 15
        enterButton.backgroundColor = activButtonColor
        enterButton.layer.cornerRadius = 15
        
        creditTextfield.becomeFirstResponder()
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(self.keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func enter(_ sender: Any) {
        let credit = Int(creditTextfield.text ?? "") ?? 0
        if credit > user_credit!.credit{
            errorLabel.isHidden = false
            errorLabel.text = "Недопустимое количество"
        } else{
            delegate?.updateCredit(credit: credit)
            self.dismissTo(vc: nil, count: 2, animated: true)
//            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
          keyboardHeight = (notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as! CGRect).height
         self.bottomConstraint.constant = 10
          
          print("var keyboardHeight: \(keyboardHeight)")
          UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
              self.bottomConstraint.constant -= self.keyboardHeight
              print("var bottomConstraint: \(self.bottomConstraint)")
                       },
                           completion:{ finished in
                             print("View is showed")
                  })
    
      }
}
