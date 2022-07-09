//
//  CartResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation
import SwiftyJSON

struct CartResponseModel : Equatable {
    var success: Bool
    var status, message: String
    var data: [CartDataModel]
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        var data = [CartDataModel]()
        if !object["data"].arrayValue.isEmpty {
            object["data"].arrayValue.forEach {
                data.append(CartDataModel(object: $0))
            }
            self.data = data
        } else {
            self.data = [CartDataModel(object: object["data"])]
        }
    }
    
    static func == (lhs: CartResponseModel, rhs: CartResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

struct CartDataModel : Equatable {
    var id : String
    var products : ProductDataModel
    var quantity : Int
    var updateAt : String
    
    init(object : JSON) {
        self.id = object["id"].stringValue
        self.quantity = object["quantity"].intValue
        self.updateAt = object["updatedAt"].stringValue
        self.products = ProductDataModel(object: object["products"])
    }
}
