//
//  ResetModel.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 22/07/22.
//

import Foundation
import SwiftyJSON

struct ResetRequestModel {
    var password: String

    func toDictionary() -> [String: Any] {
        return [
            "password": password,
        ]
    }
}

struct ResetResponseModel : Equatable {
    var message: String
    var status : String
    var success: Bool
    var data : ResetDataModel

    init(object: JSON) {
        self.message = object["message"].stringValue
        self.status = object["status"].stringValue
        self.success = object["success"].boolValue
        self.data = ResetDataModel(object: object["data"])
    }

    static func == (lhs: ResetResponseModel, rhs: ResetResponseModel) -> Bool {
        (lhs.message == rhs.message) &&
        (lhs.status == rhs.status) &&
        (lhs.success == rhs.success) &&
        (lhs.data == rhs.data)
    }
}

struct ResetDataModel : Equatable {
    var password: String

    init(object: JSON) {
        self.password = object["password"].stringValue
    }
}
