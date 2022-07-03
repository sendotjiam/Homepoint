//
//  ColorCellModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 03/07/22.
//

import Foundation

final class ColorCellModel {
    let hexColor : String
    var isSelected : Bool
    
    init(_ hexColor: String, _ isSelected: Bool) {
        self.hexColor = hexColor
        self.isSelected = isSelected
    }
}
