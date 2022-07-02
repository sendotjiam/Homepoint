//
//  ProductModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
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
    var ratingAverage, ratingCount, amountSold: Int
    var createdAt: String
    var isDeleted: Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.productSubCategories = ProductSubCategoryModel(object: object["productSubCategories"])
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
        self.ratingAverage = object["ratingAverage"].intValue
        self.ratingCount = object["ratingCount"].intValue
        self.amountSold = object["amountSold"].intValue
        self.createdAt = object["createdAt"].stringValue
        self.isDeleted = object["isDeleted"].boolValue
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

// MARK: - Product Category
struct ProductSubCategoriesResponseModel: Equatable {
    var success: Bool
    var status, message: String
    var data: [ProductSubCategoryModel]
        
    init(object : JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        var data = [ProductSubCategoryModel]()
        object["data"].arrayValue.forEach {
            data.append(ProductSubCategoryModel(object: $0))
        }
        self.data = data
    }
}

struct ProductSubCategoryModel: Equatable {
    var id, name, icon: String
    var isDeleted: Bool
    
    init(object: JSON) {
        self.id = object["id"].stringValue
        self.name = object["name"].stringValue
        self.icon = object["icon"].stringValue
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
