//
//  ShopModel.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 15.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

struct DataShop: Decodable {
    var data: [Shop]
}

struct Shop: Decodable {
    var id: Int
    var name: String
    var icon: String
}

struct DataDetailShop: Decodable {
    var data: DetailShop
}

struct DetailShop: Decodable {
    var id: Int
    var name: String
    var icon: String
    var schedule: String
    var description: String
    var address: String
    var categories: [Category]
}
