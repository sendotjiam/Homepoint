//
//  TransactionRequestModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation

struct TransactionRequestModel {
    var addressesId : String
    var bankId : String
    var shippingServicesId : String
    var storeLocation : String
    var totalPrice : Double
    var userId : String
    var transactionItems : [TransactionItemRequestModel]
    
    func toDictionary() -> [String: Any] {
        let items = transactionItems.map { item in
            item.toDictionary()
        }
        
        return [
            "addressesId" : addressesId,
            "bankId" : bankId,
            "shippingServicesId" : shippingServicesId,
            "storeLocation": storeLocation,
            "totalPrice": totalPrice,
            "userId" : userId,
            "transactionItems" : items
        ]
    }
}

struct TransactionItemRequestModel {
    var discount : Double
    var isInsurance : Bool
    var price : Double
    var productId : String
    var quantity: Int
    
    func toDictionary() -> [String: Any] {
        [
            "discount" : discount,
            "isInsurance": isInsurance,
            "price": price,
            "productId": productId,
            "quantity": quantity
        ]
    }
}
