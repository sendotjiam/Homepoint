//
//  AuthRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation

protocol UserRepositoryInterface {
    typealias GetUserById = ((UsersResponseModel?, Error?) -> Void)
    
    func login(
        params: [String: Any],
        completion: @escaping ((LoginResponseModel?, Error?) -> Void)
    )
    func register(
        params: [String: Any],
        completion: @escaping ((RegisterResponseModel?, Error?) -> Void)
    )
    
    func getUser(
        by id: String,
        completion: @escaping GetUserById )
        
    func forget(
        params: [String: Any],
        completion: @escaping ((ForgetResponseModel?, Error?) -> Void)
    )
}
