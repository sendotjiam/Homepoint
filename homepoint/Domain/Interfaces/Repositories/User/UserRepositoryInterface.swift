//
//  AuthRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation

protocol UserRepositoryInterface {
    func login(
        params: [String: Any],
        completion: @escaping ((LoginResponseModel?, Error?) -> Void)
    )
    func register(
        params: [String: Any],
        completion: @escaping ((RegisterResponseModel?, Error?) -> Void)
    )
}
