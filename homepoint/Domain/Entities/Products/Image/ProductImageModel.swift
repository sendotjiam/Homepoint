//
//  ProductModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation
import SwiftyJSON

// MARK: - ProductImage
struct ProductImageModel: Equatable {
    var id: String
    var image: String
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.image = object["image"].stringValue
    }
}
