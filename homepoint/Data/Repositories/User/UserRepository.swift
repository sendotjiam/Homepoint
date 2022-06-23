//
//  UserRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation
import SwiftyJSON

final class UserRepository {
    private let urlString = "api/v1/users/"
    
    let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension UserRepository : UserRepositoryInterface {
    func login(
        params: [String : Any],
        completion: @escaping ((LoginResponseModel?, Error?) -> Void)
    ) {
        apiClient.request(
            urlString + "login",
            .post,
            params,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = LoginResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
    
    func register(
        params: [String : Any],
        completion: @escaping ((RegisterResponseModel?, Error?) -> Void)
    ) {
        apiClient.request(
            urlString + "register",
            .post,
            params,
            nil
        ) { response, data, error in
            print(params)
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = RegisterResponseModel(object: json)
                    completion(model, error)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
}
