//
//  DescriptionPromo.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 08.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

struct DataPromoDescription: Decodable {
    let data: PromoDescription
}

struct PromoDescription: Decodable {
    let description: String
}
