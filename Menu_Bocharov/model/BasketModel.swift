//
//  BasketModel.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 29.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

class Basket {
    var to = ""
    var nameAdr = ""
    var payment_card = 1
    var payment_method = "cash"
    var promo_codes: [String] = ["string"]
    var credit = 0
    var comment: Comment = Comment(banknote: 500)
    var products: [Int] = []
    var prods: [TableProductBasket] = []
    var price = 0
}
struct TableProductBasket {
    var name = ""
    var count = 0
    var price = 0
}

struct Comment {
    var banknote: Int

}

var myBasket = Basket()

