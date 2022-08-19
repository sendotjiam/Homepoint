//
//  ProductsResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation
import SwiftyJSON

// MARK: - Product
struct ProductsResponseModel : Equatable {
    
    var success: Bool
    var status, message: String
    var data: [ProductDataModel]
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        
        var products = [ProductDataModel]()
        if !object["data"].arrayValue.isEmpty {
            object["data"].arrayValue.forEach {
                products.append(ProductDataModel(object: $0))
            }
            self.data = products
        } else {
            self.data = [ProductDataModel(object: object["data"])]
        }
    }
    
    static func == (lhs: ProductsResponseModel, rhs: ProductsResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

// MARK: - Product Data
struct ProductDataModel : Equatable {
    
    var id: String
    var productSubCategories: ProductSubCategoryModel
    var productImages: [ProductImageModel]
    var name, description, brand: String
    var price, discount: Double
    var stock: Int
    var color: String
    var ratingAverage : Double
    var ratingCount, amountSold: Int
    var createdAt: String
    var isDeleted: Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.productSubCategories = ProductSubCategoryModel(object: object["productSubcategories"])
        var images = [ProductImageModel]()
        object["productImages"].arrayValue.forEach {
            images.append(ProductImageModel(object: $0))
        }
        self.productImages = images
        self.name = object["name"].stringValue
        self.description = object["description"].stringValue
        self.brand = object["brand"].stringValue
        self.price = object["price"].doubleValue
        self.discount = object["discount"].doubleValue
        self.stock = object["stock"].intValue
        self.color = object["color"].stringValue
        self.ratingAverage = object["ratingAverage"].doubleValue
        self.ratingCount = object["ratingCount"].intValue
        self.amountSold = object["amountSold"].intValue
        self.createdAt = object["createdAt"].stringValue
        self.isDeleted = object["isDeleted"].boolValue
    }
    
    func getDiscounted(qty: Int) -> Double {
        let singleDiscountedPrice = price - (price * (discount / 100))
        return singleDiscountedPrice * Double(qty)
    }
    
    static func == (lhs: ProductDataModel, rhs: ProductDataModel) -> Bool {
        (lhs.id == rhs.id) &&
        (lhs.productSubCategories == rhs.productSubCategories) &&
        (lhs.productImages == rhs.productImages) &&
        (lhs.name == rhs.name) &&
        (lhs.description == rhs.description) &&
        (lhs.brand == rhs.brand) &&
        (lhs.price == rhs.price) &&
        (lhs.discount == rhs.discount) &&
        (lhs.stock == rhs.stock) &&
        (lhs.color == rhs.color) &&
        (lhs.ratingAverage == rhs.ratingAverage) &&
        (lhs.ratingCount == rhs.ratingCount) &&
        (lhs.amountSold == rhs.amountSold) &&
        (lhs.createdAt == rhs.createdAt) &&
        (lhs.isDeleted == rhs.isDeleted)
    }
}
