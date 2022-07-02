//
//  ProductSubCategoriesRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 02/07/22.
//

import Foundation
import SwiftyJSON

final class ProductSubCategoriesRepository {
    private let urlString = "api/v1/product-subcategories"
    
    private let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension ProductSubCategoriesRepository : ProductSubCategoriesRepositoryInterface {
    func fetchSubCategories(completion: @escaping FetchSubCategories) {
        apiClient.request(
            urlString,
            .get,
            nil,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = ProductSubCategoriesResponseModel(object: json)
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
