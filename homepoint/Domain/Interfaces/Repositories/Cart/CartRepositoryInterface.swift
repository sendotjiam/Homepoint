//
//  CartRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation

protocol CartRepositoryInterface {
    typealias CartCompletion = ((CartResponseModel?, Error?) -> Void)
    
    func addCart(params : [String: Any], completion: @escaping CartCompletion)
    func fetchCarts(userId: String, completion: @escaping CartCompletion)
    func updateCart(params: [String: Any], completion: @escaping CartCompletion)
    func deleteCart(id: String, completion: @escaping CartCompletion)
}
