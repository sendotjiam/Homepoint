//
//  BankResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import SwiftyJSON

struct BankResponseModel {
    var id : String
    var bankName : String
    var bankLogo : String
    var accountNumber : String
    var holderName: String
    var isDeleted : Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.bankName = object["bankName"].stringValue
        self.bankLogo = object["bankLogo"].stringValue
        self.accountNumber = object["accountNumber"].stringValue
        self.holderName = object["holderName"].stringValue
        self.isDeleted = object["isDeleted"].boolValue
    }
}
