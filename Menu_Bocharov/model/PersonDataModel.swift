//
//  PersonDataModel.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 19.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

var id = 2


struct DataProfile: Decodable {
    let data: Profile
}

struct Profile: Decodable {
        var email: String
        var name: String
        var phone: String
}

struct Person{
    var tittle=""
    var names:[PersonData]=[]
}

struct PersonData {
    
    var namePersonData = ""
    var placeHolderPersonData = ""
    var iconPerson = true
    var arrowImage = true
    
    static func getnames() -> [Person]{
        return [ Person(tittle: " ", names: [PersonData(namePersonData: "+7 977 375 41 93", placeHolderPersonData: " ", iconPerson: false, arrowImage: true)
                           ]
        ),
             Person(tittle: "Имя", names: [PersonData(namePersonData: "", placeHolderPersonData: "Как вас зовут?", iconPerson: true, arrowImage: false)]),
             Person(tittle: "E-mail", names: [PersonData(namePersonData: "", placeHolderPersonData: "Укажите ваш e-mail", iconPerson: true, arrowImage: false)])
             
        ]
        }
}
