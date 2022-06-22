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
    typealias FetchProducts = ((ProductsResponseModel?, Error?) -> Void)
    typealias GetProductById = ((ProductsResponseModel?, Error?) -> Void)
    typealias FetchProductsByName = ((ProductsResponseModel?, Error?) -> Void)
    
    func getProducts(
        type: FetchProductType,
        completion: @escaping FetchProducts
    )
    
    func getProducts(
        by name : String,
        completion: @escaping FetchProductsByName
    )
    
    func getProduct(
        by id: String,
        completion: @escaping GetProductById
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
        completion: @escaping FetchProducts
    ) {
        repository.fetchProducts(type: type) { result, error in
            completion(result, error)
        }
    }
    
    func getProduct(
        by id: String,
        completion: @escaping GetProductById
    ) {
        repository.getProduct(by: id) { result, error in
            completion(result, error)
        }
    }
    
    func getProducts(
        by name: String,
        completion: @escaping FetchProductsByName
    ) {
        repository.fetchProducts(by: name) { result, error in
            completion(result, error)
        }
    }
}
