//
//  WishlistUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 06/07/22.
//

import Foundation

protocol WishlistUseCaseProvider {
    typealias AddWishlistItem = ((WishlistResponseModel?, Error?) -> Void)
    typealias FetchWishlists = ((AllWishlistsResponseModel?, Error?) -> Void)
    typealias DeleteWishlist = ((WishlistResponseModel?, Error?) -> Void)
    typealias IsWishlist = ((String?, Error?) -> Void)
    typealias DeleteBulkWishlists = ((WishlistResponseModel?, Error?) -> Void)
    
    func addWishlist(
        productId: String,
        userId: String,
        completion: @escaping AddWishlistItem
    )
    
    func fetchWishlists(
        userId: String,
        completion: @escaping FetchWishlists
    )
    
    func deleteWishlist(id: String, completion: @escaping DeleteWishlist)

    func deleteBulkWishlists(ids: [String], completion: @escaping DeleteBulkWishlists)
    
    func checkProductIsWishlist(
        productId: String,
        userId: String,
        completion: @escaping IsWishlist
    )
}

final class WishlistUseCase {
    private let repository : WishlistRepository
    
    init(_ repository : WishlistRepository) {
        self.repository = repository
    }
}

extension WishlistUseCase : WishlistUseCaseProvider {
    
    func addWishlist(
        productId: String,
        userId: String,
        completion: @escaping AddWishlistItem
    ) {
        let params : [String: String] = [
            "userId" : userId,
            "productId": productId
        ]
        repository.addWishlist(params: params) { result, error in
            completion(result, error)
        }
    }
    
    func fetchWishlists(
        userId: String,
        completion: @escaping FetchWishlists
    ) {
        repository.fetchWishlists(userId: userId) { result, error in
            completion(result, error)
        }
    }
    
    func deleteWishlist(id: String, completion: @escaping DeleteWishlist) {
        repository.deleteWishlist(id: id) { result, error in
            completion(result, error)
        }
    }
    
    func deleteBulkWishlists(ids: [String], completion: @escaping DeleteBulkWishlists) {
        repository.deleteBulkWishlists(ids: ids) { result, error in
            completion(result, error)
        }
    }
    
    func checkProductIsWishlist(
        productId: String,
        userId: String,
        completion: @escaping IsWishlist
    ) {
        let params : [String: String] = [
            "userId" : userId,
            "productId": productId
        ]
        repository.checkProductIsWishlist(params: params) { result, error in
            completion(result?.data.first?.id ?? "", nil)
        }
    }
}
