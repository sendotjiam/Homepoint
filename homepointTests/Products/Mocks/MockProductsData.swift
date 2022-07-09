//
//  MockData.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation
import SwiftyJSON
@testable import homepoint

struct MockProductsData {
    
    static func generateProductsData() -> Data? {
        "{\"success\":true,\"status\":\"200 OK\",\"message\":\"Success retrieve products\",\"data\":[{\"id\":\"bd694e4d-fefb-404f-905d-c91aef19595a\",\"productSubCategories\":{\"id\":\"a923447a-2a32-4641-8e65-86a3c48699ab\",\"name\":\"Peralatan Masak\",\"isDeleted\":false},\"productImages\":[{\"id\":\"4df6692f-8791-46e5-ac5e-ec0a69ebc608\",\"image\":\"\"}],\"name\":\"Synergistic Paper Car\",\"description\":\"Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.\",\"brand\":\"Umbara-Umbara\",\"price\":75.25,\"discount\":69.16,\"stock\":21,\"color\":\"lavender\",\"ratingAverage\":1,\"ratingCount\":8,\"amountSold\":48,\"createdAt\":\"2022-06-19T05:33:01.396\",\"isDeleted\":false}]}".data(using: .utf8)
    }
    static func generateAllProductsData() -> Data? {
        "{\"success\":true,\"status\":\"200 OK\",\"message\":\"Products found successfully\",\"data\":{\"totalPage\":4,\"totalRecord\":50,\"currentPage\":0,\"pageSize\":16,\"products\":[{\"id\":\"bd694e4d-fefb-404f-905d-c91aef19595a\",\"productSubCategories\":{\"id\":\"a923447a-2a32-4641-8e65-86a3c48699ab\",\"name\":\"Peralatan Masak\",\"isDeleted\":false},\"productImages\":[{\"id\":\"4df6692f-8791-46e5-ac5e-ec0a69ebc608\",\"image\":\"\"}],\"name\":\"Synergistic Paper Car\",\"description\":\"Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.\",\"brand\":\"Umbara-Umbara\",\"price\":75.25,\"discount\":69.16,\"stock\":21,\"color\":\"lavender\",\"ratingAverage\":1,\"ratingCount\":8,\"amountSold\":48,\"createdAt\":\"2022-06-19T05:33:01.396\",\"isDeleted\":false}]}}".data(using: .utf8)
    }
    
    static func generateProducts() -> ProductsResponseModel {
        var productsResponse = generateProductsResponseModel()
        let category = generateProductSubCategoriesModel()
        let images = generateProductImagesModel()
        var datas = generateProductsDataModel()
        datas[0].productSubCategories = category
        datas[0].productImages = images
        productsResponse.data = datas
        return productsResponse
    }
    
    static func generateAllProducts() -> AllProductsResponseModel {
        var allProductsResponse = generateAllProductsResponseModel()
        var allData = generateAllProductsDataModel()
        let category = generateProductSubCategoriesModel()
        let images = generateProductImagesModel()
        var datas = generateProductsDataModel()
        datas[0].productSubCategories = category
        datas[0].productImages = images
        allData.products = datas
        allProductsResponse.data = allData
        return allProductsResponse
    }
    
    static func generateProductsResponseModel() -> ProductsResponseModel {
        ProductsResponseModel(object: JSON([
            "success": true,
            "status": "200 OK",
            "message": "Success retrieve products",
            "data": ""
        ]))
    }
    
    static func generateAllProductsResponseModel() -> AllProductsResponseModel {
        AllProductsResponseModel(object: JSON([
            "message": "Products found successfully",
            "status": "200 OK",
            "success": true,
            "data": ""
        ]))
    }
    
    static func generateAllProductsDataModel() -> AllProductsDataModel {
        AllProductsDataModel(object: JSON([
            "totalPage": 4,
            "totalRecord": 50,
            "currentPage": 0,
            "pageSize": 16,
            "products": []
        ]))
    }
    
    static func generateProductsDataModel() -> [ProductDataModel] {
        [
            ProductDataModel(object: JSON([
                "id": "bd694e4d-fefb-404f-905d-c91aef19595a",
                "productSubCategories": "",
                "productImages": [],
                "name": "Synergistic Paper Car",
                "description": "Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.",
                "brand": "Umbara-Umbara",
                "price": 75.25,
                "discount": 69.16,
                "stock": 21,
                "color": "lavender",
                "ratingAverage": 1,
                "ratingCount": 8,
                "amountSold": 48,
                "createdAt": "2022-06-19T05:33:01.396",
                "isDeleted": false
            ]))
        ]
    }
    
    static func generateProductSubCategoriesModel() -> ProductSubCategoryModel {
        ProductSubCategoryModel(object: JSON([
            "id": "a923447a-2a32-4641-8e65-86a3c48699ab",
            "name": "Peralatan Masak",
            "isDeleted": false
        ]))
    }
    
    static func generateProductImagesModel() -> [ProductImageModel] {
        [
            ProductImageModel(object: JSON([
                "id": "4df6692f-8791-46e5-ac5e-ec0a69ebc608",
                "image": ""
            ]))
        ]
    }
}
