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
        var query = "?"
        params.forEach { key, value in
            var tempKey = key
            var tempValue = value
            switch tempKey {
            case "sort":
                if tempValue as! String == "" { return }
                tempKey = checkSort(tempValue as! String)
                tempValue = true
            case "filter":
                checkFilter()
                tempValue = true
            case "Description":
                let valueStr = (tempValue as! String).split(separator: " ")
                tempValue = valueStr.joined(separator: "%20")
            default: break
            }
            query += "\(tempKey)=\(tempValue)&"
        }
        query.removeLast()
        repository.fetchProducts(queryParam: query) { result, error in
            completion(result, error)
        }
    }
    
    private func checkSort(_ value : String) -> String {
        switch value {
        case "Produk Terlaris":
            return "Sort by best seller"
        case "Produk Terbaru":
            return "Sort by latest"
        case "Harga Termurah":
            return "Sort by price asc"
        case "Harga Termahal":
            return "Sort by price desc"
        case "Diskon Terbesar":
            return "Sort by discount"
        default: return ""
        }
    }
    
    private func checkFilter() {
        
    }
}
