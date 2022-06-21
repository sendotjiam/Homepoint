//
//  ProductsUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation

enum FetchProductType {
    case latest, discount, all
}

protocol ProductsUseCaseProvider {
    func getProducts(
        type: FetchProductType,
        completion: @escaping ((ProductsResponseModel?, Error?) -> ())
    )
    
    func getProduct(
        by id: String,
        completion: @escaping ((ProductsResponseModel?, Error?) -> ())
    )
}

final class ProductsUseCase {
    private let repository : ProductsRepositoryInterface
    
    init(_ repository : ProductsRepositoryInterface) {
        self.repository = repository
    }
}

extension ProductsUseCase : ProductsUseCaseProvider {
    func getProducts(
        type: FetchProductType,
        completion: @escaping ((ProductsResponseModel?, Error?) -> ())
    ) {
        repository.fetchProducts(type: type) { result, error in
            completion(result, error)
        }
    }
    
    func getProduct(
        by id: String,
        completion: @escaping ((ProductsResponseModel?, Error?) -> ())
    ) {
        repository.getProduct(by: id) { result, error in
            completion(result, error)
        }
    }
}
