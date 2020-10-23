//
//  File.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 19.08.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import Foundation
import UIKit

let backgroundColor = UIColor(hexString: "#E5E5E5", alpha: 1)
let colortitleSection = UIColor(hexString: "#8A8A8D", alpha: 1)
let activButtonColor = UIColor(hexString: "#3D3BFF", alpha: 1)
let unActivButtonColor = UIColor(hexString: "#D0D0D0", alpha: 1)
let horViewForAddress = UIColor(hexString: "#007AFF", alpha: 1)
let horlineView = UIColor(hexString: "#C6C6C8", alpha: 1)

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
