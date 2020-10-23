//
//  Item.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 23.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation
import UIKit

struct DataItem: Decodable {
    var data: [Item]
}

struct Item: Decodable {
    var id: Int
    var name: String
    var icon: String
    var is_category: Bool
    var price: Int
    var producing: String
    var hit: Int
    var sale: Int
    var composition: String
    var weight: Int
    var unit: String
}


class DataProduct {
    var dataP: [Product]
    
    init?(data: NSDictionary) {
        dataP = data["data"] as! [Product]
    }
}

class Product {
    var id: Int
    var name: String
    var icon: String
    var is_category: Bool
    var price: Int
    var producing: String
    var hit: Int
    var sale: Int
    var composition: String
    var weight: Int
    var unit: String
    var color: UIColor = .white
    
    init?(subdata: NSDictionary) {
//        let subdata = data["data"] as! NSDictionary
//        for sub in subdata{
        id = subdata["id"] as? Int ?? 0
        name = subdata["name"] as? String ?? ""
        icon = subdata["icon"] as? String ?? ""
        is_category = subdata["is_category"] as? Bool ?? false
//        if is_category == true {
        price = subdata["price"] as? Int ?? 0
        producing = subdata["producing"] as? String ?? ""
        hit = subdata["hit"] as? Int ?? 0
        sale = subdata["sale"] as? Int ?? 0
        composition = subdata["composition"] as? String ?? ""
        weight = subdata["weight"] as? Int ?? 0
        unit = subdata["unit"] as? String ?? ""

    
    }
    
}





