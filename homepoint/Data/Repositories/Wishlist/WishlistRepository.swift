//
//  WishlistRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 06/07/22.
//

import Foundation
import SwiftyJSON

final class WishlistRepository {
    private let urlString = "api/v1/wishlist"
    
    private let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension WishlistRepository : WishlistRepositoryInterface {
    
    func addWishlist(
        params: [String : Any],
        completion: @escaping AddWishlistItem
    ) {
        guard let userId = params["userId"],
              let productId = params["productId"]
        else { return }
        apiClient.request(
            urlString + "/items/\(userId)/\(productId)",
            .post,
            [:],
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = WishlistResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func fetchWishlists(
        userId: String,
        completion: @escaping FetchWishlists
    ) {
        apiClient.request(
            urlString + "/\(userId)?page=0&size=12",
            .get,
            nil,
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = AllWishlistsResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func deleteWishlist(id: String, completion: @escaping DeleteWishlist) {
        apiClient.request(
            urlString + "/items/\(id)",
            .delete,
            [:],
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = WishlistResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func deleteBulkWishlists(ids: [String], completion: @escaping DeleteBulkWishlists) {
        let params = ["wishlistItemIds": ids]
        apiClient.request(
            urlString + "/items",
            .delete,
            params,
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = WishlistResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func checkProductIsWishlist(
        params: [String : Any],
        completion: @escaping CheckProductIsWishlist
    ) {
        guard let userId = params["userId"],
              let productId = params["productId"]
        else { return }
        apiClient.request(
            urlString + "/items/\(userId)/\(productId)",
            .get,
            nil,
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = WishlistResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
}
