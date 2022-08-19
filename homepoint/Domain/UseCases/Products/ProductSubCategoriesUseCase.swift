//
//  ProductSubCategoriesUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 02/07/22.
//

import Foundation

protocol ProductSubCategoriesProvider {
    typealias FetchSubCategories = ((ProductSubCategoriesResponseModel?, Error?) -> Void)
    
    func getSubCategories(
        completion: @escaping FetchSubCategories
    )
}

final class ProductSubCategoriesUseCase {
    private let repository : ProductSubCategoriesRepositoryInterface
    
    init(_ repository : ProductSubCategoriesRepositoryInterface) {
        self.repository = repository
    }
}

extension ProductSubCategoriesUseCase : ProductSubCategoriesProvider {
    func getSubCategories(completion: @escaping FetchSubCategories) {
        repository.fetchSubCategories { result, error in
            completion(result, error)
        }
    }
}
