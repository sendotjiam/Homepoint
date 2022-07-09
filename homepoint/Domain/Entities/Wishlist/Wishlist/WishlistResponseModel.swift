//
//  WishlistResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 06/07/22.
//

import Foundation
import SwiftyJSON

struct WishlistResponseModel : Equatable {
    var success: Bool
    var status, message: String
    var data: WishlistDataModel
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        self.data = WishlistDataModel(object: object["data"])
    }
    
    static func == (lhs: WishlistResponseModel, rhs: WishlistResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

struct WishlistDataModel : Equatable {
    var id: String
    var createdAt: String
    var isDeleted: Bool
    var products : ProductDataModel
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.createdAt = object["createdAt"].stringValue
        self.isDeleted = object["isDeleted"].boolValue
        self.products = ProductDataModel(object: object["products"])
    }
}
