//
//  OrderListItemCellModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 07/06/22.
//

import Foundation

final class OrderListItemCellModel {
    let title : String
    let imageUrl : String
    let date : String
    let status : OrderStatusType
    let amount: Int
    let price : Int
    
    init(title: String,
         imageUrl : String,
         date : String,
         status : OrderStatusType,
         amount : Int,
         price : Int
    ) {
        self.title = title
        self.imageUrl = imageUrl
        self.date = date
        self.status = status
        self.amount = amount
        self.price = price
    }
}
