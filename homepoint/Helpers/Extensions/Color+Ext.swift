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
    case redColor, lightRedColor
    case greenColor, lightGreenColor
    case purpleColor, lightPurpleColor
    case yellowColor, lightYellowColor
    case darkGreenColor
    case maroonColor
    case pinkColor
    case darkYellowColor
    case creamColor
    case lightGreyColor
    case lightTealColor
    case lightBlueColor
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
            case .lightRedColor:
                return UIColor(red: 0.988, green: 0.894, blue: 0.894, alpha: 1)
            case .greenColor:
                return UIColor(red: 0.078, green: 0.717, blue: 0.019, alpha: 1)
            case .lightGreenColor:
                return UIColor(red: 0.815, green: 1, blue: 0.749, alpha: 1)
            case .purpleColor:
                return UIColor(red: 0.015, green: 0.047, blue: 0.368, alpha: 1)
            case .lightPurpleColor:
                return UIColor(red: 0.768, green: 0.784, blue: 0.952, alpha: 1)
            case .yellowColor:
                return UIColor(red: 1, green: 0.768, blue: 0, alpha: 1)
            case .lightYellowColor:
                return UIColor(red: 0.992, green: 0.98, blue: 0.717, alpha: 1)
            case .darkGreenColor:
                return UIColor(red: 0, green: 0.486, blue: 0.427, alpha: 1)
            case .maroonColor:
                return UIColor(red: 0.588, green: 0.004, blue: 0.458, alpha: 1)
            case .pinkColor:
                return UIColor(red: 0.988, green: 0.894, blue: 0.968, alpha: 1)
            case .darkYellowColor:
                return UIColor(red: 0.839, green: 0.604, blue: 0.047, alpha: 1)
            case .creamColor:
                return UIColor(red: 1, green: 0.945, blue: 0.815, alpha: 1)
            case .lightGreyColor:
                return UIColor(red: 0.882, green: 0.913, blue: 0.937, alpha: 1)
            case .lightTealColor:
                return UIColor(red: 0.784, green: 0.894, blue: 0.905, alpha: 1)
            case .lightBlueColor:
                return UIColor(red: 0.737, green: 0.874, blue: 0.956, alpha: 1)
            }
        }
    }
}
