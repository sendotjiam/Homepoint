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
            let parsed = RepositoryManager.shared.parse(data: data)
            if let json = parsed.json {
                let model = ProductSubCategoriesResponseModel(object: json)
                completion(model, nil)
            } else {
                completion(nil, parsed.error)
            }
        }
    }
}
