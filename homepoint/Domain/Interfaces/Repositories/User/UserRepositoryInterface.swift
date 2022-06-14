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
        completion: @escaping ((Result<LoginResponseModel, Error>) -> Void)
    )
    func register(
        params: [String: Any],
        completion: @escaping ((Result<RegisterResponseModel, Error>) -> Void)
    )
}
