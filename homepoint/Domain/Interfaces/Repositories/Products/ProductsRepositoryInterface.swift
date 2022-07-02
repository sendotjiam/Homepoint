//
//  ProductsRepositoryInterfcae.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation

protocol ProductsRepositoryInterface {
    typealias FetchProducts = ((ProductsResponseModel?, Error?) -> Void)
    typealias GetProductById = ((ProductsResponseModel?, Error?) -> Void)
    typealias SearchProducts = ((AllProductsResponseModel?, Error?) -> Void)
    
    func fetchProducts(
        type: FetchProductType,
        completion: @escaping FetchProducts
    )
    
    func getProduct(
        by id: String,
        completion: @escaping GetProductById
    )
    
    func fetchProducts(
        queryParam: String,
        completion: @escaping SearchProducts
    )
}
