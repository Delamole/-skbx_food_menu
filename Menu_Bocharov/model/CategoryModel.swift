//
//  CategoryModel.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 16.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

struct DataCategory: Decodable {
    var data: [Category]
}

struct Category: Decodable {
    var id: Int
    var name: String
    var icon: String
    var is_category: Bool
}
