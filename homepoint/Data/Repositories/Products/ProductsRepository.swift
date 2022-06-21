//
//  ProductsRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation
import SwiftyJSON

final class ProductsRepository {
    private let urlString = "api/v1/products/"
    
    let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension ProductsRepository : ProductsRepositoryInterface {
    func fetchProducts(
        type: FetchProductType,
        completion: @escaping ((ProductsResponseModel?, Error?) -> Void)
    ) {
        var url = urlString
        switch type {
        case .discount: url += "discount"
        case .latest: url += "latest"
        default : break
        }
        apiClient.request(
            url,
            .get,
            nil,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = ProductsResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
    
    func getProduct(
        by id: String,
        completion: @escaping ((ProductsResponseModel?, Error?) -> Void)
    ) {
        apiClient.request(
            urlString + id,
            .get,
            nil,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = ProductsResponseModel(object: json)
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
