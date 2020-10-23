//
//  PayMethod.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 07.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation



struct PayMethod {
    
    var name = ""
    var icon = ""
    var check = ""
    
    static func getnames() -> [PayMethod]{
        return [ PayMethod(name: "Наличные", icon: "Vector-9", check: "greenButton"),
                 PayMethod(name: "Карта **** 2045", icon: "visa_PNG30 1", check: "grayButton"),
                 PayMethod(name: "Apple Pay", icon: "Vector-10", check: "grayButton")
             
        ]
        }
}
