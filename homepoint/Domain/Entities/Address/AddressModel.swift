//
//  AddressModel.swift
//  homepoint
//
//  Created by Kartika on 24/07/22.
//

import Foundation
import SwiftyJSON

struct AddressRequestModel {
    var id, label, province, city, districts, village, zipCode, fullAddress, recipientName, phoneNumber, usersId: String
    var isActive: Bool
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "label": label,
            "province": province,
            "city": city,
            "districts": districts,
            "village": village,
            "zipCode": zipCode,
            "fullAddress": fullAddress,
            "recipientName": recipientName,
            "phoneNumber": phoneNumber,
            "usersId": usersId,
            "isActive": isActive
        ]
    }
}

struct AddressResponseModel : Equatable {
    var success: Bool
    var status, message: String
    var data: AddressDataModel
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        self.data = AddressDataModel(object: object["data"])
    }
}

struct AddressDataModel : Equatable {
    var id, label, province, city, districts, village, zipCode, fullAddress, recipientName, phoneNumber: String
    var isActive: Bool
    
    init(object : JSON) {
        self.id = object["id"].stringValue
        self.label = object["label"].stringValue
        self.province = object["province"].stringValue
        self.city = object["city"].stringValue
        self.districts = object["districts"].stringValue
        self.village = object["village"].stringValue
        self.zipCode = object["zipCode"].stringValue
        self.fullAddress = object["fullAddress"].stringValue
        self.recipientName = object["recipientName"].stringValue
        self.phoneNumber = object["phoneNumber"].stringValue
        self.isActive = object["isActive"].boolValue
    }
    
    static func == (lhs: AddressDataModel, rhs: AddressDataModel) -> Bool {
        (lhs.id == rhs.id) &&
        (lhs.label == rhs.label) &&
        (lhs.province == rhs.province) &&
        (lhs.city == rhs.city) &&
        (lhs.districts == rhs.districts) &&
        (lhs.village == rhs.village) &&
        (lhs.zipCode == rhs.zipCode) &&
        (lhs.fullAddress == rhs.fullAddress) &&
        (lhs.recipientName == rhs.recipientName) &&
        (lhs.phoneNumber == rhs.phoneNumber) &&
        (lhs.isActive == rhs.isActive)
    }
}
