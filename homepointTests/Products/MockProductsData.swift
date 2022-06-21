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
        "{ \"success\": true, \"status\": \"200 OK\", \"message\": \"Success retrieve products\", \"data\": [ { \"id\": \"bd694e4d-fefb-404f-905d-c91aef19595a\", \"productCategories\": { \"id\": \"a923447a-2a32-4641-8e65-86a3c48699ab\", \"name\": \"Peralatan Masak\", \"isDeleted\": false },  \"productImages\": [ { \"id\": \"01d08d7c-4891-42e9-b453-ba895a54f621\", \"image\": \"https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png\" }, { \"id\": \"6ebf34ab-b8f6-4ee0-bf6d-ecb10be19ba0\", \"image\": \"https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png\" }, { \"id\": \"4df6692f-8791-46e5-ac5e-ec0a69ebc608\", \"image\": \"https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png\" } ], \"name\": \"Synergistic Paper Car\", \"description\": \"Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.\", \"brand\": \"Umbara-Umbara\", \"price\": 75.25, \"discount\": 69.16, \"stock\": 21, \"color\": \"lavender\", \"ratingAverage\": 1, \"ratingCount\": 8, \"amountSold\": 48, \"createdAt\": \"2022-06-19T05:33:01.396\", \"isDeleted\": false } ] }".data(using: .utf8)
    }
    
    
//"{
//    \"success\": true,
//    \"status\": \"200 OK\",
//    \"message\": \"Success retrieve latest products\",
//    \"data\": [
//        {
//            \"id\": \"bd694e4d-fefb-404f-905d-c91aef19595a\",
//            \"productCategories\":
//                {
//                    \"id\": \"a923447a-2a32-4641-8e65-86a3c48699ab\",
//                    \"name\": \"Peralatan Masak\",
//                    \"isDeleted\": false
//                },
//            \"productImages\": [
//                {
//                    \"id\": \"01d08d7c-4891-42e9-b453-ba895a54f621\",
//                    \"image\": \"https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png\"
//                }, {
//                    \"id\": \"6ebf34ab-b8f6-4ee0-bf6d-ecb10be19ba0\", \"image\": \"https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png\"
//                }, {
//                    \"id\": \"4df6692f-8791-46e5-ac5e-ec0a69ebc608\", \"image\": \"https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png\"
//                }
//            ],
//            \"name\": \"Synergistic Paper Car\",
//            \"description\": \"Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.\",
//            \"brand\": \"Umbara-Umbara\",
//            \"price\": 75.25,
//            \"discount\": 69.16,
//            \"stock\": 21,
//            \"color\": \"lavender\",
//            \"ratingAverage\": 1,
//            \"ratingCount\": 8,
//            \"amountSold\": 48,
//            \"createdAt\": \"2022-06-19T05:33:01.396\",
//            \"isDeleted\": false
//        }
//    ]
//}"
    
    
//    ("ProductsResponseModel(success: true, status: "200 OK", message: "Success retrieve latest products", data: [homepoint.ProductDataModel(id: "bd694e4d-fefb-404f-905d-c91aef19595a", productCategories: homepoint.ProductCategoryModel(id: "a923447a-2a32-4641-8e65-86a3c48699ab", name: "Peralatan Masak", isDeleted: false), productImages: [homepoint.ProductImageModel(id: "01d08d7c-4891-42e9-b453-ba895a54f621", image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"), homepoint.ProductImageModel(id: "6ebf34ab-b8f6-4ee0-bf6d-ecb10be19ba0", image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"), homepoint.ProductImageModel(id: "4df6692f-8791-46e5-ac5e-ec0a69ebc608", image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png")], name: "Synergistic Paper Car", description: "Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.", brand: "Umbara-Umbara", price: 75.25, discount: 69.16, stock: 21, color: "lavender", ratingAverage: 1, ratingCount: 8, amountSold: 48, createdAt: "2022-06-19T05:33:01.396", isDeleted: false)])") is not equal to
//     
//     ("ProductsResponseModel(success: true, status: "200 OK", message: "Success retrieve products", data: [homepoint.ProductDataModel(id: "bd694e4d-fefb-404f-905d-c91aef19595a", productCategories: homepoint.ProductCategoryModel(id: "a923447a-2a32-4641-8e65-86a3c48699ab", name: "Peralatan Masak", isDeleted: false), productImages: [homepoint.ProductImageModel(id: "01d08d7c-4891-42e9-b453-ba895a54f621", image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"), homepoint.ProductImageModel(id: "6ebf34ab-b8f6-4ee0-bf6d-ecb10be19ba0", image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"), homepoint.ProductImageModel(id: "4df6692f-8791-46e5-ac5e-ec0a69ebc608", image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png")], name: "Synergistic Paper Car", description: "Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.", brand: "Umbara-Umbara", price: 75.25, discount: 69.16, stock: 21, color: "lavender", ratingAverage: 1, ratingCount: 8, amountSold: 48, createdAt: "2022-06-19T05:33:01.396", isDeleted: false)])")

    
    static func generateProducts() -> ProductsResponseModel {
        var productsResponse = generateProductsResponseModel()
        var category = generateProductCategoriesModel()
        var images = generateProductImagesModel()
        var datas = generateProductsDataModel()
        datas[0].productCategories = category
        datas[0].productImages = images
        productsResponse.data = datas
        print(productsResponse, "PRODUCT RESP")
        return productsResponse
    }
    
//    ProductsResponseModel(
//        success: true,
//        status: "200 OK",
//        message: "Success retrieve products",
//        data: [
//            ProductDataModel(
//                id: "bd694e4d-fefb-404f-905d-c91aef19595a",
//                productCategories: ProductCategoryModel(
//                    id: "a923447a-2a32-4641-8e65-86a3c48699ab",
//                    name: "Peralatan Masak", isDeleted: false),
//                productImages: [
//                    ProductImageModel(
//                        id: "01d08d7c-4891-42e9-b453-ba895a54f621",
//                        image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"
//                    ),
//                    ProductImageModel(
//                        id: "6ebf34ab-b8f6-4ee0-bf6d-ecb10be19ba0",
//                        image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"
//                    ), ProductImageModel(
//                        id: "4df6692f-8791-46e5-ac5e-ec0a69ebc608",
//                        image: "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"
//                    )
//                ],
//                name: "Synergistic Paper Car",
//                description: "Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.",
//                brand: "Umbara-Umbara",
//                price: 75.25,
//                discount: 69.16,
//                stock: 21,
//                color: "lavender",
//                ratingAverage: 1,
//                ratingCount: 8,
//                amountSold: 48,
//                createdAt: "2022-06-19T05:33:01.396",
//                isDeleted: false
//            )
//        ]
//    )
    
    private static func generateProductsResponseModel() -> ProductsResponseModel {
        ProductsResponseModel(object: JSON([
            "message": "Success retrieve products",
            "status": "200 OK",
            "success": true,
            "data": ""
        ]))
    }
    
    private static func generateProductsDataModel() -> [ProductDataModel] {
        [
            ProductDataModel(object: JSON([
                "id": "bd694e4d-fefb-404f-905d-c91aef19595a",
                "productCategories": "",
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
    
    private static func generateProductCategoriesModel() -> ProductCategoryModel {
        ProductCategoryModel(object: JSON([
            "id": "a923447a-2a32-4641-8e65-86a3c48699ab",
            "name": "Peralatan Masak",
            "isDeleted": false
        ]))
    }
    
    private static func generateProductImagesModel() -> [ProductImageModel] {
        [
            ProductImageModel(object: JSON([
                "id": "01d08d7c-4891-42e9-b453-ba895a54f621",
                "image": "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"
            ])),
            ProductImageModel(object: JSON([
                "id": "6ebf34ab-b8f6-4ee0-bf6d-ecb10be19ba0",
                "image": "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"
            ])),
            ProductImageModel(object: JSON([
                "id": "4df6692f-8791-46e5-ac5e-ec0a69ebc608",
                "image": "https://res.cloudinary.com/ipassya/image/upload/v1655386668/homepoint/seeders/products_xztozb.png"
            ])),
        ]
    }
}
