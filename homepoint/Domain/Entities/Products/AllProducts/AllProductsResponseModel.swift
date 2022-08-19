//
//  AllProductsResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 06/07/22.
//

import Foundation
import SwiftyJSON

// MARK: - All Products
struct AllProductsResponseModel : Equatable {
    var success: Bool
    var status, message: String
    var data: AllProductsDataModel
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        self.data = AllProductsDataModel(object: object["data"])
    }
    
    static func == (lhs: AllProductsResponseModel, rhs: AllProductsResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

struct AllProductsDataModel : Equatable {
    var totalPage : Int
    var totalRecord : Int
    var currentPage : Int
    var pageSize: Int
    var products : [ProductDataModel]
    
    init(object: JSON) {
        self.totalPage = object["totalPage"].intValue
        self.totalRecord = object["totalRecord"].intValue
        self.currentPage = object["currentPage"].intValue
        self.pageSize = object["pageSize"].intValue
        var products = [ProductDataModel]()
        object["products"].arrayValue.forEach {
            products.append(ProductDataModel(object: $0))
        }
        self.products = products
    }
    
    static func == (lhs: AllProductsDataModel, rhs: AllProductsDataModel) -> Bool {
        (lhs.totalPage == rhs.totalPage) &&
        (lhs.totalRecord == rhs.totalRecord) &&
        (lhs.pageSize == rhs.pageSize) &&
        (lhs.currentPage == rhs.currentPage) &&
        (lhs.products == rhs.products)
    }
}
