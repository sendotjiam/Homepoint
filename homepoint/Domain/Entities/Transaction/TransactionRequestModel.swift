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
    var totalPrice : Int
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
            "totalPrice": totalPrice,
            "userId" : userId,
            "transactionItems" : items
        ]
    }
}

struct TransactionItemRequestModel {
    var discount : Int
    var id : String
    var isInsurance : Bool
    var price : Int
    var productId : String
    var quantity: Int
    
    func toDictionary() -> [String: Any] {
        [
            "discount" : discount,
            "id": id,
            "isInsurance": isInsurance,
            "price": price,
            "productId": productId,
            "quantity": quantity
        ]
    }
}
