//
//  AllWishlistsResponseModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation
import SwiftyJSON

struct AllWishlistsResponseModel : Equatable {
    var success: Bool
    var status, message: String
    var data: AllWishlistsDataModel
    
    init(object: JSON) {
        self.success = object["success"].boolValue
        self.status = object["status"].stringValue
        self.message = object["message"].stringValue
        self.data = AllWishlistsDataModel(object: object["data"])
    }
    
    static func == (lhs: AllWishlistsResponseModel, rhs: AllWishlistsResponseModel) -> Bool {
        (lhs.success == rhs.success) &&
        (lhs.status == rhs.status) &&
        (lhs.message == rhs.message) &&
        (lhs.data == rhs.data)
    }
}

struct AllWishlistsDataModel : Equatable {
    var totalPage : Int
    var totalRecord : Int
    var currentPage : Int
    var pageSize: Int
    var wishlistItems : [WishlistDataModel]
    
    init(object: JSON) {
        self.totalPage = object["totalPage"].intValue
        self.totalRecord = object["totalRecord"].intValue
        self.currentPage = object["currentPage"].intValue
        self.pageSize = object["pageSize"].intValue
        var wishlists = [WishlistDataModel]()
        object["wishlistItems"].arrayValue.forEach {
            wishlists.append(WishlistDataModel(object: $0))
        }
        self.wishlistItems = wishlists
    }
}
