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
    init() {}
}

extension UserRepository : UserRepositoryInterface {
    func login(
        params: [String : Any],
        completion: @escaping ((Result<LoginResponseModel, Error>) -> Void)
    ) {
        AFApiClient.shared.request(
            urlString + "login",
            .post,
            params
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = LoginResponseModel(object: json)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    func register(
        params: [String : Any],
        completion: @escaping ((Result<RegisterResponseModel, Error>) -> Void)
    ) {
        AFApiClient.shared.request(
            urlString + "register",
            .post,
            params
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = RegisterResponseModel(object: json)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error as! Error))
            }
        }
    }
}
