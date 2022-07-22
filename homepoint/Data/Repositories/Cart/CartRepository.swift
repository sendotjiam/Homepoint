//
//  CartRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation
import SwiftyJSON
import RxSwift
import Alamofire

final class CartRepository {
    private let urlString = "api/v1/cart"
    
    private let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension CartRepository : CartRepositoryInterface {
    func addCart(params: [String : Any], completion: @escaping CartCompletion) {
        guard let userId = params["userId"],
              let productId = params["productId"],
              let quantity = params["quantity"]
        else { return }
        let queryParams = "\(userId)/\(productId)"
        let headers : HTTPHeaders = ["Content-Type": "application/json"]
        apiClient.requestBodyEncoding(
            urlString + "/items/\(queryParams)",
            .post,
            [:],
            headers,
            "\(quantity)"
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = CartResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func fetchCarts(userId: String, completion: @escaping CartCompletion) {
        apiClient.request(
            urlString + "/\(userId)",
            .get,
            nil,
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = CartResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func updateCart(params: [String : Any], completion: @escaping CartCompletion) {
        guard let id = params["id"],
              let quantity = params["quantity"]
        else { return }
        let bodyParam = ["quantity": quantity]
        apiClient.request(
            urlString + "/items/\(id)",
            .put,
            bodyParam,
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = CartResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func deleteCart(id: String, completion: @escaping CartCompletion) {
        apiClient.request(
            urlString + "/items/\(id)",
            .delete,
            nil,
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = CartResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
    
    func deleteBulkCarts(ids: [String], completion: @escaping CartCompletion) {
        let params = ["cartItemIds": ids]
        apiClient.request(
            urlString + "/items",
            .delete,
            params,
            nil
        ) { response, data, error in
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = CartResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
}
