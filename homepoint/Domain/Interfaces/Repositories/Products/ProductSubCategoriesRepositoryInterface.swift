//
//  ProductSubCategoriesRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 02/07/22.
//

import Foundation

protocol ProductSubCategoriesRepositoryInterface {
    typealias FetchSubCategories = ((ProductSubCategoriesResponseModel?, Error?) -> Void)
    
    func fetchSubCategories(
        completion: @escaping FetchSubCategories
    )
}
