//
//  Promo.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 27.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

import Foundation


struct PromoCode: Decodable {
//    var code = "R-155382"
//    var validity = 7200
//    var date_activation = "2020-09-01T11:57:12.000000Z"
//    var used = false
//    var description = "По этому промокоду для вас действует скидка 15% на первый заказ в сервисе «Еда» (срок действия – 2 часа)"
//    var short_description = "15% на первый заказ в сервисе «Еда»"
//    var sale = 15
//
//    init?(data: NSDictionary) {
//        let subdata = data["data"] as? NSDictionary
//        code = subdata?["code"] as? String ?? ""
//        validity = subdata?["validity"] as? Int ?? 0
//        date_activation = subdata?["date_activation"] as? String ?? ""
//        description = subdata?["description"] as? String ?? ""
//        short_description = subdata?["short_description"] as? String ?? ""
//        used = subdata?["used"] as? Bool ?? false
//        sale = subdata?["sale"] as? Int ?? 0
//       }
}

struct DataPromo: Decodable {
    let data: [Promos]
}

struct Promos: Decodable {
    let id: Int
        var code: String
        var validity: Int
        var date_activation: String
        var used: Bool
        var description: String
        var short_description: String
        var sale: Int
}



struct Promo {
    
    
    var name = ""
    var description = ""
    var durationTime = ""
    var icon = ""
    
    var isActive = true
    
    static func getnames() -> [Promo]{
         return [ Promo(name: "R - 1234567", description: "- 50% в сети магазинов Перекрёсток, Лента, Мясновъ", durationTime: "Истекает через: 5 дней ", icon: "soonfinishPromo", isActive: true),
                  Promo(name: "R - 1450881", description: "- 30% на любой тариф в сервисе «Такси»", durationTime: "Истекает через: 7 дней  ", icon: "soonfinishPromo", isActive: true),
                  Promo(name: "R - 1450444", description: "- 15% на заказ в сервисе «Еда» ", durationTime: "Истекает через: 8 дней  ", icon: "soonfinishPromo", isActive: true),
                  Promo(name: "R - 1450882", description: "- 30% на любой тариф в сервисе «Такси»", durationTime: "Промокод был использован: 03.09.20", icon: "activPromo", isActive: false),
             Promo(name: "R - 1450882", description: "- 20% на поездку по тарифу Standart", durationTime: "Истёк срок действия: 24.08.20", icon: "finishPromo", isActive: false),
               Promo(name: "R - 1450445", description: "- 15% на заказ в сервисе «Еда» ", durationTime: "Истёк срок действия: 24.08.20", icon: "finishPromo", isActive: false),
             Promo(name: "R - 1450882", description: "- 30% на любой тариф в сервисе «Такси»", durationTime: "Промокод был использован: 03.09.20", icon: "activPromo", isActive: false),
                            ]
        
              
         
         }
}


