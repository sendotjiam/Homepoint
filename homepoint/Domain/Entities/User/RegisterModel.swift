//
//  RegisterModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation
import SwiftyJSON

struct RegisterRequestModel {
    var email: String
    var name: String
    var password : String
    
    func toDictionary() -> [String: Any] {
        return [
            "email": email,
            "name": name,
            "password": password
        ]
    }
}

struct RegisterResponseModel : Equatable {
    var message: String
    var status : String
    var success: Bool
    var data : RegisterDataModel
    
    init(object: JSON) {
        self.message = object["message"].stringValue
        self.status = object["status"].stringValue
        self.success = object["success"].boolValue
        self.data = RegisterDataModel(object: object["data"])
    }
    
    static func == (lhs: RegisterResponseModel, rhs: RegisterResponseModel) -> Bool {
        (lhs.message == rhs.message) &&
        (lhs.status == rhs.status) &&
        (lhs.success == rhs.success) &&
        (lhs.data == rhs.data)
    }
}

struct RegisterDataModel : Equatable {
    var email: String
    var name: String
    var password : String
    
    init(object: JSON) {
        self.email = object["email"].stringValue
        self.name = object["name"].stringValue
        self.password = object["password"].stringValue
    }
    
}
