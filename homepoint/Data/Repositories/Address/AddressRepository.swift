//
//  AddressRepository.swift
//  homepoint
//
//  Created by Kartika on 25/07/22.
//

import Foundation
import SwiftyJSON
import Alamofire

final class AddressRepository {
    private let urlString = "api/v1/address/"
    
    let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension AddressRepository : AddressRepositoryInterface {
    func addAddress(params: [String : Any], completion: @escaping AddressCompletion) {
        apiClient.request(
            urlString,
            .post,
            params,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = AddressResponseModel(object: json)
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
