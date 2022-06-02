//
//  Color+Ext.swift
//  homepoint
//
//  Created by Kartika on 31/05/22.
//

import Foundation
import UIKit

enum ColorCollection {
    case primaryColor
    case secondaryColor
    case blueDarkColor
    case blueColor
    case blueLigthColor
    case whiteColor
    case cyanColor
    case darkestTextColor
    case darkTextColor
    case grayTextColor
    case ligthTextColor
    case ligthestTextColor
    case redColor
}

extension ColorCollection {
    var value: UIColor {
        get {
            switch self {
            case .primaryColor:
                return UIColor(red: 0.192, green: 0.376, blue: 0.576, alpha: 1)
            case .secondaryColor:
                return UIColor(red: 0.983, green: 0.776, blue: 0.275, alpha: 1)
            case .blueDarkColor:
                return UIColor(red: 0.133, green: 0.212, blue: 0.29, alpha: 1)
            case .blueColor:
                return UIColor(red: 0.412, green: 0.6, blue: 0.722, alpha: 1)
            case .blueLigthColor:
                return UIColor(red: 0.596, green: 0.714, blue: 0.788, alpha: 1)
            case .whiteColor:
                return UIColor(red: 0.961, green: 0.965, blue: 0.973, alpha: 1)
            case .cyanColor:
                return UIColor(red: 0.78, green: 0.933, blue: 0.918, alpha: 1)
            case .darkestTextColor:
                return UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
            case .darkTextColor:
                return UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1)
            case .grayTextColor:
                return UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1)
            case .ligthTextColor:
                return UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
            case .ligthestTextColor:
                return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            case .redColor:
                return UIColor(red: 0.938, green: 0.037, blue: 0.037, alpha: 1)
            }
        }
    }
}
