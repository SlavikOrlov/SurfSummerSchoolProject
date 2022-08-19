//
//  ColorExtension.swift
//  SurfSummerSchoolProject
//
//  Created by Slava Orlov on 19.08.2022.
//

import UIKit

class ColorsExtension {
    static let white = UIColor(rgb: 0xFFFFFF)
    static let black = UIColor(rgb: 0x000000)
    static let red = UIColor(rgb: 0xF35858)
    static let lightGray = UIColor(rgb: 0xB3B3B3)
    static let backgroundWhite = UIColor(rgb: 0xFFFFFF)
    static let lightTextGray = UIColor(rgb: 0xB0B0B0)
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
