//
//  ProductsUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation

enum FetchProductType {
    case latest, discount
}

protocol ProductsUseCaseProvider {
    typealias FetchProducts = ((ProductsResponseModel?, Error?) -> Void)
    typealias GetProductById = ((ProductsResponseModel?, Error?) -> Void)
    typealias SearchProducts = ((AllProductsResponseModel?, Error?) -> Void)
    
    func getProducts(
        type: FetchProductType,
        completion: @escaping FetchProducts
    )
    
    func getProducts(
        params: [String : Any],
        completion: @escaping SearchProducts
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
        params: [String : Any],
        completion: @escaping SearchProducts
    ) {
        repository.fetchProducts(params: params) { result, error in
            completion(result, error)
        }
    }
}
