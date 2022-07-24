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
    var addresses : AddressResponseModel
    var createdAt : String
    var id : String
    var paymentDeadline : String
    var paymentProof : String
    var shippingServices : String
    var status : String
    var totalPrice :Int
    var transactionItems : [TransactionItemDataModel]
    var users: UsersDataModel
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.createdAt = object["createdAt"].stringValue
        self.paymentDeadline = object["paymentDeadline"].stringValue
        self.paymentProof = object["paymentProof"].stringValue
        self.shippingServices = object["shippingServices"].stringValue
        self.status = object["status"].stringValue
        self.totalPrice = object["totalPrice"].intValue
        self.addresses = AddressResponseModel(object: object["addresses"])
        self.users = UsersDataModel(object: object["users"])
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
        object["products"].arrayValue.forEach {
            products.append(ProductDataModel(object: $0))
        }
        self.products = products
    }
}
