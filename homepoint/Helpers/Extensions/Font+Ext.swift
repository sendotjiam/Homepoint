//
//  String+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import UIKit

enum FontType: String {
    case thin = "Inter-Thin"
    case extraLigth = "Inter-ExtraLight"
    case ligth = "Inter-Light"
    case regular = "Inter-Regular"
    case semiBold = "Inter-SemiBold"
    case bold = "Inter-Bold"
    case extraBold = "Inter-ExtraBold"
}

extension UIFont {
    static func font(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
