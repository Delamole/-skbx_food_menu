//
//  CreditModel.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 13.10.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

struct DataCreditModel: Decodable {
    let data: CreditModel
}

struct CreditModel: Decodable {
    let credit: Int
}
