//
//  WishlistRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 06/07/22.
//

import Foundation

protocol WishlistRepositoryInterface {
    typealias AddWishlistItem = ((WishlistResponseModel?, Error?) -> Void)
    typealias FetchWishlists = ((AllWishlistsResponseModel?, Error?) -> Void)
    typealias DeleteWishlist = ((WishlistResponseModel?, Error?) -> Void)
    typealias CheckProductIsWishlist = ((WishlistResponseModel?, Error?) -> Void)
    
    func addWishlist(params : [String: Any], completion: @escaping AddWishlistItem)
    func fetchWishlists(userId: String, completion: @escaping FetchWishlists)
    func deleteWishlist(id: String, completion: @escaping DeleteWishlist)
    func checkProductIsWishlist(params: [String: Any], completion : @escaping CheckProductIsWishlist)
}
