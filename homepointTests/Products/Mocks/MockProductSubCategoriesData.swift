//
//  MockSubCategoryData.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 02/07/22.
//

import Foundation
import SwiftyJSON
@testable import homepoint

struct MockProductSubCategoriesData {
    static func generateProductSubCategoriesData() -> Data? {
        "{\"success\":true,\"status\":\"200 OK\",\"message\":\"Product subcategories retrieved successfully\",\"data\":[{\"id\":\"a440e81f-9be7-4175-851c-251d917c9e21\",\"name\":\"Aksesoris Dapur\",\"icon\":\"https://res.cloudinary.com/hasalreadybeentaken/image/upload/v1656166550/Homepoint/Kategori/Sub%20kategori/Aksesoris_dapur_mixgoa.png\",\"isDeleted\":false}]}".data(using: .utf8)
    }
    
    static func generateProductSubCategories() -> ProductSubCategoriesResponseModel {
        var response = generateProductSubCategoriesResponseModel()
        response.data = generateSubCategoriesModel()
        return response
    }
    
    static func generateProductSubCategoriesResponseModel() -> ProductSubCategoriesResponseModel {
        ProductSubCategoriesResponseModel(object: JSON([
            "success": true,
            "status": "200 OK",
            "message": "Product subcategories retrieved successfully",
            "data": ""
        ]))
    }
    
    static func generateSubCategoriesModel() -> [ProductSubCategoryModel] {
        [
            ProductSubCategoryModel(object: JSON([
                "id": "a440e81f-9be7-4175-851c-251d917c9e21",
                "name": "Aksesoris Dapur",
                "icon": "https://res.cloudinary.com/hasalreadybeentaken/image/upload/v1656166550/Homepoint/Kategori/Sub%20kategori/Aksesoris_dapur_mixgoa.png",
                "isDeleted": false
            ]))
        ]
    }
}
