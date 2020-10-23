//
//  IntToDay.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 09.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation

extension Int {
     func days() -> String {
         var dayString: String!
         if "1".contains("\(self % 10)")      {dayString = "час"}
         if "234".contains("\(self % 10)")    {dayString = "часа" }
         if "567890".contains("\(self % 10)") {dayString = "часов"}
         if 11...14 ~= self % 100                   {dayString = "часов"}
    return "\(self) " + dayString
    }
}
