//
//  ProductsRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation
import SwiftyJSON

final class ProductsRepository {
    private let urlString = "api/v1/products"
    
    let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension ProductsRepository : ProductsRepositoryInterface {
    func fetchProducts(
        type: FetchProductType,
        completion: @escaping FetchProducts
    ) {
        var url = urlString
        switch type {
        case .discount: url += "/discount"
        case .latest: url += "/latest"
        }
        apiClient.request(
            url,
            .get,
            nil,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = ProductsResponseModel(object: json)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
    
    func fetchProducts(
        params : [String : Any] = [:],
        completion: @escaping SearchProducts
    ) {
        var query = "?"
        params.forEach { key, value in
            var tempKey = key
            var tempValue = value
            if tempKey == "sort" {
                switch tempValue as! String {
                case "Produk Terlaris":
                    tempKey = "Sort by best seller"
                case "Produk Terbaru":
                    tempKey = "Sort by latest"
                case "Harga Termurah":
                    tempKey = "Sort by price asc"
                case "Harga Termahal":
                    tempKey = "Sort by price desc"
                default: break
                }
                tempValue = true
            }
            let splitStr = tempKey.split(separator: " ")
            query += "\(splitStr.joined(separator: "%20"))=\(tempValue)&"
        }
        query.removeLast()
        let url = urlString + query
        print(url, "URL")
        apiClient.request(
            url,
            .get,
            nil,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = AllProductsResponseModel(object: json)
                    print(json, model)
                    completion(model, nil)
                } catch {
                    completion(nil, NetworkError.EmptyDataError)
                }
            } else {
                completion(nil, NetworkError.ApiError)
            }
        }
    }
    
    func getProduct(
        by id: String,
        completion: @escaping GetProductById
    ) {
        apiClient.request(
            urlString + id,
            .get,
            nil,
            nil
        ) { response, data, error in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    let model = ProductsResponseModel(object: json)
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
