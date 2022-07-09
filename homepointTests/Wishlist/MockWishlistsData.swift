//
//  MockWishlistsData.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation
import SwiftyJSON
@testable import homepoint

struct MockWishlistsData {
    
    // MARK: - WishlistResponse
    static func generateWishlistsData() -> Data? {
        "{\"success\":true,\"status\":\"200 OK\",\"message\":\"Wishlist item added successfully\",\"data\":{\"id\":\"94d50c87-6e4a-4a65-b7a8-650e8c11a7ce\",\"products\":{\"id\":\"bd694e4d-fefb-404f-905d-c91aef19595a\",\"productSubCategories\":{\"id\":\"a923447a-2a32-4641-8e65-86a3c48699ab\",\"name\":\"Peralatan Masak\",\"isDeleted\":false},\"productImages\":[{\"id\":\"4df6692f-8791-46e5-ac5e-ec0a69ebc608\",\"image\":\"\"}],\"name\":\"Synergistic Paper Car\",\"description\":\"Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.\",\"brand\":\"Umbara-Umbara\",\"price\":75.25,\"discount\":69.16,\"stock\":21,\"color\":\"lavender\",\"ratingAverage\":1,\"ratingCount\":8,\"amountSold\":48,\"createdAt\":\"2022-06-19T05:33:01.396\",\"isDeleted\":false},\"createdAt\":\"2022-07-09T09:26:32.753+00:00\"}}".data(using: .utf8)
        
    }
    
    static func generateWishlists() -> WishlistResponseModel {
        var response = generateWishlistsResponseModel()
        var data = generateWishlistsDataModel()
        data.products = MockProductsData.generateProductsDataModel()[0]
        data.products.productSubCategories = MockProductsData.generateProductSubCategoriesModel()
        data.products.productImages = MockProductsData.generateProductImagesModel()
        response.data = data
        return response
    }
    
    static func generateWishlistsResponseModel() -> WishlistResponseModel {
        WishlistResponseModel(object: JSON([
            "success": true,
            "status": "200 OK",
            "message": "Wishlist item added successfully",
            "data": ""
        ]))
    }
    
    static func generateWishlistsDataModel() -> WishlistDataModel {
        WishlistDataModel(object: JSON([
            "id": "94d50c87-6e4a-4a65-b7a8-650e8c11a7ce",
            "products": "",
            "createdAt": "2022-07-09T09:26:32.753+00:00"
        ]))
    }
    
    // MARK: - AllWishlistsResponse
    static func generateAllWishlistsData() -> Data? {
        "{\"success\":true,\"status\":\"200 OK\",\"message\":\"Wishlist found successfully\",\"data\":{\"totalPage\":1,\"totalRecord\":1,\"currentPage\":0,\"pageSize\":1,\"wishlistItems\":[{\"id\":\"94d50c87-6e4a-4a65-b7a8-650e8c11a7ce\",\"products\":{\"id\":\"bd694e4d-fefb-404f-905d-c91aef19595a\",\"productSubCategories\":{\"id\":\"a923447a-2a32-4641-8e65-86a3c48699ab\",\"name\":\"Peralatan Masak\",\"isDeleted\":false},\"productImages\":[{\"id\":\"4df6692f-8791-46e5-ac5e-ec0a69ebc608\",\"image\":\"\"}],\"name\":\"Synergistic Paper Car\",\"description\":\"Laboriosam optio mollitia. Architecto enim suscipit fugit et omnis. Minus saepe expedita saepe reprehenderit.\",\"brand\":\"Umbara-Umbara\",\"price\":75.25,\"discount\":69.16,\"stock\":21,\"color\":\"lavender\",\"ratingAverage\":1,\"ratingCount\":8,\"amountSold\":48,\"createdAt\":\"2022-06-19T05:33:01.396\",\"isDeleted\":false},\"createdAt\":\"2022-07-09T09:26:32.753+00:00\"}]}}".data(using: .utf8)
    }
    
    static func generateAllWishlists() -> AllWishlistsResponseModel {
        var response = generateAllWishlistsResponseModel()
        var data = generateAllWishlistsDataModel()
        data.wishlistItems = [generateWishlistsDataModel()]
        data.wishlistItems[0].products = MockProductsData.generateProductsDataModel()[0]
        data.wishlistItems[0].products.productSubCategories = MockProductsData.generateProductSubCategoriesModel()
        data.wishlistItems[0].products.productImages = MockProductsData.generateProductImagesModel()
        response.data = data
        return response
    }
    
    static func generateAllWishlistsResponseModel() -> AllWishlistsResponseModel {
        AllWishlistsResponseModel(object: JSON([
            "success": true,
            "status": "200 OK",
            "message": "Wishlist found successfully",
            "data": ""
        ]))
        
    }
    
    static func generateAllWishlistsDataModel() -> AllWishlistsDataModel {
        AllWishlistsDataModel(object: JSON([
            "totalPage": 1,
            "totalRecord": 1,
            "currentPage": 0,
            "pageSize": 1,
            "wishlistItems": ""
        ]))
    }
    
    
}
