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
}
