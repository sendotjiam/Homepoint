//
//  UserRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation
import SwiftyJSON
import Alamofire

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
        let headers : HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        apiClient.request(
            urlString + "login",
            .post,
            params,
            headers
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
    
    func getUser (by id: String, completion: @escaping UserCompletion) {
//        if(!(id == ))
        apiClient.request(
            urlString + id,
            .get,
            nil,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = UserResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
    
//    func updateUser (params: [String: Any], completion: @escaping UserCompletion) {
    func updateUser (params: [String: Any], completion: @escaping UserCompletion) {
        apiClient.request(
            urlString,
            .put,
            params,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = UserResponseModel(object: json)
                    completion(model, nil)
                    } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }

    func forget(
        params: [String : Any],
        completion: @escaping ((ForgetResponseModel?, Error?) -> Void)
    ) {
        let headers : HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        apiClient.request(
            urlString + "forgot_password",
            .post,
            params,
            headers
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = ForgetResponseModel(object: json)
                    completion(model, error)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }

    func reset(
        params: [String : Any],
        completion: @escaping ((ResetResponseModel?, Error?) -> Void)
    ) {
        let headers : HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        apiClient.request(
            urlString + "reset_password",
            .post,
            params,
            headers
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = ResetResponseModel(object: json)
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
