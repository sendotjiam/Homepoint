//
//  CartUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation

protocol CartUseCaseProvider {
    typealias CartCompletion = ((CartResponseModel?, Error?) -> Void)
    
    func addCart(userId : String, productId : String, qty: Int, completion: @escaping CartCompletion)
    func fetchCarts(userId: String, completion: @escaping CartCompletion)
    func updateCart(params: [String : Any], completion: @escaping CartCompletion)
    func deleteCart(id: String, completion: @escaping CartCompletion)
    func deleteBulkCarts(ids: [String], completion: @escaping CartCompletion)
}


final class CartUseCase {
    private let repository : CartRepositoryInterface
    
    init(_ repository : CartRepositoryInterface = CartRepository()) {
        self.repository = repository
    }
}

extension CartUseCase : CartUseCaseProvider {
    func addCart(userId : String, productId : String, qty: Int, completion: @escaping CartCompletion) {
        let params : [String : Any] = [
            "userId": userId,
            "productId": productId,
            "quantity": qty
        ]
        repository.addCart(params: params) { result, error in
            completion(result, error)
        }
    }
    
    func fetchCarts(userId: String, completion: @escaping CartCompletion) {
        repository.fetchCarts(userId: userId) { result, error in
            completion(result, error)
        }
    }
    
    func updateCart(params: [String : Any], completion: @escaping CartCompletion) {
        repository.updateCart(params: params) { result, error in
            completion(result, error)
        }
    }
    
    func deleteCart(id: String, completion: @escaping CartCompletion) {
        repository.deleteCart(id: id) { result, error in
            completion(result, error)
        }
    }
    
    func deleteBulkCarts(ids: [String], completion: @escaping CartCompletion) {
        repository.deleteBulkCarts(ids: ids) { result, error in
            completion(result, error)
        }
    }
}
