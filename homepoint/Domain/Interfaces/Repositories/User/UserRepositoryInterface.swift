//
//  AuthRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation

protocol UserRepositoryInterface {
    typealias UserCompletion = ((UserResponseModel?, Error?) -> Void)
    
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
        completion: @escaping UserCompletion )
        
    func forget(
        params: [String: Any],
        completion: @escaping ((ForgetResponseModel?, Error?) -> Void)
    )

    func reset(
        params: [String: Any],
        completion: @escaping ((ResetResponseModel?, Error?) -> Void)
    )
    
    func updateUser(
        params: [String: Any],
        completion: @escaping UserCompletion
    )
}
