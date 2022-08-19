//
//  ProductSubCategoriesResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 06/07/22.
//

import Foundation
import SwiftyJSON

// MARK: - Product Category
struct ProductSubCategoriesResponseModel: Equatable {
    var success: Bool
    var status, message: String
    var data: [ProductSubCategoryModel]
        
    init(object : JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        var data = [ProductSubCategoryModel]()
        object["data"].arrayValue.forEach {
            data.append(ProductSubCategoryModel(object: $0))
        }
        self.data = data
    }
}

struct ProductSubCategoryModel: Equatable {
    var id, name, icon: String
    var isDeleted: Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.name = object["name"].stringValue
        self.icon = object["icon"].stringValue
        self.isDeleted = object["isDeleted"].boolValue
    }
}
