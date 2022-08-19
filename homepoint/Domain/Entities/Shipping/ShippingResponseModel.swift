//
//  ShippingResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import SwiftyJSON

struct ShippingResponseModel {
    var id : String
    var courierType : String
    var icon : String
    var shippingCost : Int
    var isDeleted : Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.courierType = object["courierType"].stringValue
        self.icon = object["icon"].stringValue
        self.shippingCost = object["shippingCost"].intValue
        self.isDeleted = object["isDeleted"].boolValue
    }
}
