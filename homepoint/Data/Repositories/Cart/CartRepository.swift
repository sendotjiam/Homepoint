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
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = CartResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
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
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = CartResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
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
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = CartResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
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
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = CartResponseModel(object: json)
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
