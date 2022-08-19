//
//  ForgetModel.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 16/07/22.
//

import Foundation
import SwiftyJSON

struct ForgetRequestModel {
    var email: String

    func toDictionary() -> [String: Any] {
        return [
            "email": email,
        ]
    }
}

struct ForgetResponseModel : Equatable {
    var message: String
    var status : String
    var success: Bool
    var data : ForgetDataModel

    init(object: JSON) {
        self.message = object["message"].stringValue
        self.status = object["status"].stringValue
        self.success = object["success"].boolValue
        self.data = ForgetDataModel(object: object["data"])
    }

    static func == (lhs: ForgetResponseModel, rhs: ForgetResponseModel) -> Bool {
        (lhs.message == rhs.message) &&
        (lhs.status == rhs.status) &&
        (lhs.success == rhs.success) &&
        (lhs.data == rhs.data)
    }
}

struct ForgetDataModel : Equatable {
    var email: String

    init(object: JSON) {
        self.email = object["email"].stringValue
    }
}
