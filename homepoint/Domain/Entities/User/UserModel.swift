//
//  UserModel.swift
//  homepoint
//
//  Created by Kartika on 17/07/22.
//

import Foundation
import SwiftyJSON

// MARK: - Users
struct UsersResponseModel : Equatable {
    
    var success: Bool
    var status, message: String
    var data: [UsersDataModel]
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        
        var users = [UsersDataModel]()
        if !object["data"].arrayValue.isEmpty {
            object["data"].arrayValue.forEach {
                users.append(UsersDataModel(object: $0))
            }
            self.data = users
        } else {
            self.data = [UsersDataModel(object: object["data"])]
        }
    }
    
    static func == (lhs: UsersResponseModel, rhs: UsersResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

// MARK: - Users Data
struct UsersDataModel : Equatable {
    
    var id: String
//    var addresses: [ProductImageModel]
    var name, phoneNumber, email, birthDate, gender: String
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.name = object["name"].stringValue
        self.phoneNumber = object["phoneNumber"].stringValue
        self.email = object["email"].stringValue
        self.birthDate = object["birthDate"].stringValue
        self.gender = object["gender"].stringValue
    }
    
    static func == (lhs: UsersDataModel, rhs: UsersDataModel) -> Bool {
        (lhs.id == rhs.id) &&
        (lhs.name == rhs.name) &&
        (lhs.phoneNumber == rhs.phoneNumber) &&
        (lhs.email == rhs.email) &&
        (lhs.birthDate == rhs.birthDate) &&
        (lhs.gender == rhs.gender)
    }
}
