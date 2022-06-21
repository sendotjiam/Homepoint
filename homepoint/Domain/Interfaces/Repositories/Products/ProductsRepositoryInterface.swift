//
//  ProductsRepositoryInterfcae.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation

protocol ProductsRepositoryInterface {
    func fetchProducts(
        type: FetchProductType,
        completion: @escaping ((ProductsResponseModel?, Error?) -> Void)
    )
}
