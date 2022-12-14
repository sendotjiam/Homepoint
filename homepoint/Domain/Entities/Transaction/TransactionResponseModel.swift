//
//  TransactionResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import SwiftyJSON

struct TransactionResponseModel {
    var message, status: String
    var success : Bool
    var data : [TransactionDataModel]
    
    init(object: JSON) {
        self.message = object["message"].stringValue
        self.status = object["status"].stringValue
        self.success = object["success"].boolValue
        
        var data = [TransactionDataModel]()
        if !object["data"].arrayValue.isEmpty {
            object["data"].arrayValue.forEach {
                data.append(TransactionDataModel(object: $0))
            }
            self.data = data
        } else {
            self.data = [TransactionDataModel(object: object["data"])]
        }
    }
}

struct TransactionDataModel {
    var addresses : AddressDataModel
    var createdAt : String
    var id : String
    var paymentDeadline : String
    var paymentProof : String
    var shippingServices : ShippingResponseModel
    var bank : BankResponseModel
    var storeLocation : String
    var status : String
    var totalPrice :Int
    var transactionItems : [TransactionItemDataModel]
    var users: UserDataModel
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.createdAt = object["createdAt"].stringValue
        self.paymentDeadline = object["paymentDeadline"].stringValue
        self.paymentProof = object["paymentProof"].stringValue
        self.shippingServices = ShippingResponseModel(object: object["shippingServices"])
        self.bank = BankResponseModel(object: object["bank"])
        self.storeLocation = object["storeLocation"].stringValue
        self.status = object["status"].stringValue
        self.totalPrice = object["totalPrice"].intValue
        self.addresses = AddressDataModel(object: object["addresses"])
        self.users = UserDataModel(object: object["users"])
        var transactionItems = [TransactionItemDataModel]()
        object["transactionItems"].arrayValue.forEach {
            transactionItems.append(TransactionItemDataModel(object: $0))
        }
        self.transactionItems = transactionItems
    }
}

struct TransactionItemDataModel {
    var id : String
    var isInsurance : Bool
    var price : Int
    var products : [ProductDataModel]
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.isInsurance = object["isInsurance"].boolValue
        self.price = object["price"].intValue
        
        var products = [ProductDataModel]()
        if !object["products"].arrayValue.isEmpty {
            self.products = object["products"].arrayValue.map { ProductDataModel(object: $0) }
        } else {
            self.products = [ProductDataModel(object: object["products"])]
        }
    }
}
