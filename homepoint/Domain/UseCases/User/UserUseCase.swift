//
//  LoginUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation

protocol UserUseCaseProvider {
    func login(
        request: LoginRequestModel,
        completion: @escaping ((LoginResponseModel?, Error?) -> ())
    )
    func register(
        request: RegisterRequestModel,
        completion: @escaping ((RegisterResponseModel?, Error?) -> ())
    )
}

final class UserUseCase {

    private let repository : UserRepositoryInterface
    
    init(_ repository : UserRepositoryInterface) {
        self.repository = repository
    }
}

extension UserUseCase : UserUseCaseProvider {
    func login(
        request: LoginRequestModel,
        completion: @escaping ((LoginResponseModel?, Error?) -> ())
    ) {
        repository.login(params: request.toDictionary()) { (result, error) in
            completion(result, error)
        }
    }
    
    func register(
        request: RegisterRequestModel,
        completion: @escaping ((RegisterResponseModel?, Error?) -> ())
    ) {
        repository.register(params: request.toDictionary()) { (result, error) in
            completion(result, error)
        }
    }

}
