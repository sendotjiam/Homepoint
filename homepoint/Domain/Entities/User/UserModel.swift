//
//  UserModel.swift
//  homepoint
//
//  Created by Kartika on 17/07/22.
//

import Foundation
import SwiftyJSON

struct UserRequestModel {
    var id: String
    var addresses: [AddressDataModel]
    var name, phoneNumber, email, joinedSince, birthDate, gender: String
    var isActive: Bool
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "addresses": addresses,
            "name": name,
            "phoneNumber": phoneNumber,
            "email": email,
            "joinedSince": joinedSince,
            "birthdate": birthDate,
            "gender": gender,
            "isActive": isActive
        ]
    }
}

// MARK: - User
struct UserResponseModel : Equatable {
    
    var success: Bool
    var status, message: String
    var data: [UserDataModel]
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        
        var user = [UserDataModel]()
        if !object["data"].arrayValue.isEmpty {
            object["data"].arrayValue.forEach {
                user.append(UserDataModel(object: $0))
            }
            self.data = user
        } else {
            self.data = [UserDataModel(object: object["data"])]
        }
    }
    
    static func == (lhs: UserResponseModel, rhs: UserResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

// MARK: - User Data
struct UserDataModel : Equatable {
    
    var id: String
    var addresses: [AddressDataModel]
    var name, phoneNumber, email, joinedSince, birthDate, gender: String
    var isActive: Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.name = object["name"].stringValue
        self.phoneNumber = object["phoneNumber"].stringValue
        self.email = object["email"].stringValue
        self.joinedSince = object["joinedSince"].stringValue
        self.birthDate = object["birthDate"].stringValue
        self.gender = object["gender"].stringValue
        self.isActive = object["isActive"].boolValue
        
        var data = [AddressDataModel]()
        if !object["addresses"].arrayValue.isEmpty {
            object["addresses"].arrayValue.forEach {
                data.append(AddressDataModel(object: $0))
            }
            self.addresses = data
        } else {
            self.addresses = [AddressDataModel(object: object["data"])]
        }
    }
    
    static func == (lhs: UserDataModel, rhs: UserDataModel) -> Bool {
        (lhs.id == rhs.id) &&
        (lhs.addresses == rhs.addresses) &&
        (lhs.name == rhs.name) &&
        (lhs.phoneNumber == rhs.phoneNumber) &&
        (lhs.email == rhs.email) &&
        (lhs.joinedSince == rhs.joinedSince) &&
        (lhs.birthDate == rhs.birthDate) &&
        (lhs.gender == rhs.gender) &&
        (lhs.isActive == rhs.isActive)
    }
}
