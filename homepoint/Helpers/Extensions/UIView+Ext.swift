//
//  UIView+Ext.swift
//  homepoint
//
//  Created by Sendo Tjiam on 31/05/22.
//

import UIKit

extension UIView {
    func dropShadow(
        with opacity: Float,
        radius: CGFloat,
        offset: CGSize = .zero
    ) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
    func addBorder(width : CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func roundedCorner(with radius : CGFloat) {
        self.layer.cornerRadius = radius
    }
}
