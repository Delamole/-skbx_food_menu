//
//  EnumRequest.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 22.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

var url_api = "http://85.119.145.2/api/user/"

enum EnumRequest: String {
    case shop = "/shops"
    case category = "/products"
    case address = "/address"
}
