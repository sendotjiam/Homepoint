//
//  LoginModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation
import SwiftyJSON

struct LoginRequestModel {
    var email: String
    var password : String
    
    func toDictionary() -> [String: Any] {
        return [
            "email": email,
            "password": password
        ]
    }
}

struct LoginResponseModel : Equatable {
    
    var message: String
    var status : String
    var success: Bool
    var data : LoginDataModel
    
    init(object: JSON) {
        self.message = object["message"].stringValue
        self.status = object["status"].stringValue
        self.success = object["success"].boolValue
        self.data = LoginDataModel(object: object["data"])
    }
    
    static func == (lhs: LoginResponseModel, rhs: LoginResponseModel) -> Bool {
        (lhs.message == rhs.message) &&
        (lhs.status == rhs.status) &&
        (lhs.success == rhs.success) &&
        (lhs.data == rhs.data)
    }
}

struct LoginDataModel : Equatable {
    var token: String
    
    init(object: JSON) {
        self.token = object["token"].stringValue
    }
}
