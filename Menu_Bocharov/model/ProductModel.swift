//
//  ProductModel.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 28.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

struct OneProductData: Decodable {
    var data: OneProduct
}

struct OneProduct: Decodable {
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
