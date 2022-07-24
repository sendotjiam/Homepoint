//
//  AddressResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import SwiftyJSON

struct AddressResponseModel {
    var city : String
    var districts: String
    var fullAddress : String
    var id : String
    var isActive :Bool
    var label : String
    var phoneNumber : String
    var province : String
    var recipientName : String
    var village : String
    var zipCode : String
    
    init(object: JSON) {
        self.city = object["city"].stringValue
        self.districts = object["districts"].stringValue
        self.fullAddress = object["fullAddress"].stringValue
        self.id = object["id"].stringValue
        self.isActive = object["isActive"].boolValue
        self.label = object["label"].stringValue
        self.phoneNumber = object["phoneNumber"].stringValue
        self.province = object["province"].stringValue
        self.recipientName = object["recipientName"].stringValue
        self.village = object["village"].stringValue
        self.zipCode = object["zipCode"].stringValue
    }
}
