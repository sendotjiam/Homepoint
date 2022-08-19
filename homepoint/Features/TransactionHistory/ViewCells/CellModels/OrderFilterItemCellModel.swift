//
//  OrderFilterItemCellModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 07/06/22.
//

import Foundation

final class OrderFilterItemCellModel {
    let title : String
    let imageUrl : String
    var isSelected : Bool
    
    init(title: String,
         imageUrl : String,
         isSelected: Bool
    ) {
        self.title = title
        self.imageUrl = imageUrl
        self.isSelected = isSelected
    }
}
