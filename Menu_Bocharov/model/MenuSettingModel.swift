//
//  MenuSettingModel.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 19.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

struct ClassSetting: Decodable {
    let data: Settings
}

struct Settings: Decodable {

        var language: String
        var do_not_call: Bool
        var notification_discount: Bool
        var update_mobile_network: Bool
    
    enum CodingKeys: String, CodingKey {
           case language
           case do_not_call
           case notification_discount
           case update_mobile_network
       }

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.language = try values.decode(String.self, forKey: .language)
        self.do_not_call = try values.decode(Bool.self, forKey: .do_not_call)
        self.notification_discount = try values.decode(Bool.self, forKey: .notification_discount)
        self.update_mobile_network = try values.decode(Bool.self, forKey: .update_mobile_network)
        
    }
}




struct Menu{
    var tittle=""
    var names:[Setting]=[]
}


struct Setting {
    
    var nameSettring = ""
    var switchSetting = true
    var switchIsOn = true
    var arrowSetting = true
    var language = true
    var languageText = ""
    
    static func getnames() -> [Menu]{
    return [ Menu(tittle: " ", names: [Setting(nameSettring: "Язык", switchSetting: true, switchIsOn: true, arrowSetting: false, language: false, languageText: "Русский"),
                           Setting(nameSettring: "Персональные данные", switchSetting: true,switchIsOn: true, arrowSetting: false, language: true, languageText: ""),
                           Setting(nameSettring: "Push-уведомления вместо звонка", switchSetting: false,switchIsOn: true, arrowSetting: true, language: true, languageText: "")]
        ),
             Menu(tittle: " ", names: [Setting(nameSettring: "Уведомления об акциях", switchSetting: false,switchIsOn: true, arrowSetting: true, language: true, languageText: ""),
             Setting(nameSettring: "Доступные акции", switchSetting: true,switchIsOn: true, arrowSetting: false, language: true, languageText: "")]),
             Menu(tittle: "Автоматическое обновление данных геолокации", names: [Setting(nameSettring: "Обновлять по сотовой сети", switchSetting: false,switchIsOn: true, arrowSetting: true, language: true, languageText: "")])
             
        ]
        }
}
