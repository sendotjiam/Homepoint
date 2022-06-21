//
//  ProductModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
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
        object["data"].arrayValue.forEach { obj in
            products.append(ProductDataModel(object: obj))
        }
        self.data = products
    }
    
    static func == (lhs: ProductsResponseModel, rhs: ProductsResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

// MARK: - Datum
struct ProductDataModel : Equatable {
    
    var id: String
    var productCategories: ProductCategoryModel
    var productImages: [ProductImageModel]
    var name, description, brand: String
    var price, discount: Double
    var stock: Int
    var color: String
    var ratingAverage, ratingCount, amountSold: Int
    var createdAt: String
    var isDeleted: Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.productCategories = ProductCategoryModel(object: object["productCategories"])
        var images = [ProductImageModel]()
        object["productImages"].arrayValue.forEach { obj in
            images.append(ProductImageModel(object: obj))
        }
        self.productImages = images
        self.name = object["name"].stringValue
        self.description = object["description"].stringValue
        self.brand = object["brand"].stringValue
        self.price = object["price"].doubleValue
        self.discount = object["discount"].doubleValue
        self.stock = object["stock"].intValue
        self.color = object["color"].stringValue
        self.ratingAverage = object["ratingAverage"].intValue
        self.ratingCount = object["ratingCount"].intValue
        self.amountSold = object["amountSold"].intValue
        self.createdAt = object["createdAt"].stringValue
        self.isDeleted = object["isDeleted"].boolValue
    }
    
    static func == (lhs: ProductDataModel, rhs: ProductDataModel) -> Bool {
        (lhs.id == rhs.id) &&
        (lhs.productCategories == rhs.productCategories) &&
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

// MARK: - Product Category
struct ProductCategoryModel: Equatable {
    var id, name: String
    var isDeleted: Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.name = object["name"].stringValue
        self.isDeleted = object["isDeleted"].boolValue
    }
}

// MARK: - ProductImage
struct ProductImageModel: Equatable {
    var id: String
    var image: String
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.image = object["image"].stringValue
    }
}
