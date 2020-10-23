//
//  SubCategory.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 17.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

struct DataSubCategory: Decodable {
    var data: [SubCategory]
}

struct SubCategory: Decodable {
    var id: Int
    var name: String
    var icon: String
    var is_category: Bool
}
