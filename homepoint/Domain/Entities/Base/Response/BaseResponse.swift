//
//  BaseResponse.swift
//  homepoint
//
//  Created by Sendo Tjiam on 21/06/22.
//

import Foundation
import SwiftyJSON

class Response {
    var status: String
    var message: String
//    let pagination: Pagination?
    var success: Bool

    init(object: JSON) {
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        self.success = object["success"].boolValue
    }
}

final class BaseResponse<T> : Response {
    var data: T?
}
