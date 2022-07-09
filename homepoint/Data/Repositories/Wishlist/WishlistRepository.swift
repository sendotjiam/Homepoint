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
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = WishlistResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
    
    func fetchWishlists(
        userId: String,
        completion: @escaping FetchWishlists
    ) {
        apiClient.request(
            urlString + "/\(userId)",
            .get,
            [:],
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = AllWishlistsResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
    
    func deleteWishlist(id: String, completion: @escaping DeleteWishlist) {
        apiClient.request(
            urlString + "/\(id)",
            .delete,
            [:],
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = WishlistResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
}
