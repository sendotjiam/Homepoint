//
//  MockCartData.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation
import SwiftyJSON
@testable import homepoint

struct MockCartData {
    
    static func generateCartsData() -> Data? {
        "{\"success\":true,\"status\":\"200 OK\",\"message\":\"Cart item added successfully\",\"data\": [{\"id\":\"10a7e9e1-b254-4615-a1cb-a11ef86a2449\",\"updatedAt\":\"2022-07-07T08:16:04.092+00:00\",\"quantity\":5,\"products\":{\"id\":\"bd694e4d-fefb-404f-905d-c91aef19595a\",\"productSubCategories\":{\"id\":\"a923447a-2a32-4641-8e65-86a3c48699ab\",\"name\":\"Peralatan Masak\",\"isDeleted\":false},\"productImages\":[{\"id\":\"4df6692f-8791-46e5-ac5e-ec0a69ebc608\",\"image\":\"\"}],\"name\":\"Synergistic Paper Car\",\"description\":\"Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.\",\"brand\":\"Umbara-Umbara\",\"price\":75.25,\"discount\":69.16,\"stock\":21,\"color\":\"lavender\",\"ratingAverage\":1,\"ratingCount\":8,\"amountSold\":48,\"createdAt\":\"2022-06-19T05:33:01.396\",\"isDeleted\":false } }] }".data(using: .utf8)
    }
    
    static func generateCart() -> CartResponseModel {
        var response = generateCartResponseModel()
        var data = generateCartDataModel()
        data.products = MockProductsData.generateProductsDataModel()[0]
        data.products.productSubCategories = MockProductsData.generateProductSubCategoriesModel()
        data.products.productImages = MockProductsData.generateProductImagesModel()
        response.data = [data]
        return response
    }
    
    static func generateCartResponseModel() -> CartResponseModel {
        CartResponseModel(object: JSON([
            "success": true,
            "status": "200 OK",
            "message": "Cart item added successfully",
            "data": ""
        ]))
    }
    
    static func generateCartDataModel() -> CartDataModel {
        CartDataModel(object: JSON([
            "id": "10a7e9e1-b254-4615-a1cb-a11ef86a2449",
            "updatedAt": "2022-07-07T08:16:04.092+00:00",
            "quantity": 5,
            "products": ""
        ]))
    }
}
