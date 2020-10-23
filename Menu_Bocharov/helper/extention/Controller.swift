//
//  Controller.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 02.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func dismissTo(vc: UIViewController?, count: Int?, animated: Bool, completion: (() -> Void)? = nil) {
        var loopCount = 0
        var dummyVC: UIViewController? = self
        for _ in 0..<(count ?? 100) {
            loopCount = loopCount + 1
            dummyVC = dummyVC?.presentingViewController
            if let dismissToVC = vc {
                if dummyVC != nil && dummyVC!.isKind(of: dismissToVC.classForCoder) {
                    dummyVC?.dismiss(animated: animated, completion: completion)
                }
            }
        }
        
        if count != nil {
            dummyVC?.dismiss(animated: animated, completion: completion)
        }
    }
    
}
