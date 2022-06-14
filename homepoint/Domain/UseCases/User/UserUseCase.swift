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

final class UserUseCase : UserUseCaseProvider {

    private let repository : UserRepository
    
    init(_ repository : UserRepository) {
        self.repository = repository
    }
    
    func login(
        request: LoginRequestModel,
        completion: @escaping ((LoginResponseModel?, Error?) -> ())
    ) {
        repository.login(params: request.toDictionary()) { result in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func register(
        request: RegisterRequestModel,
        completion: @escaping ((RegisterResponseModel?, Error?) -> ())
    ) {
        repository.register(params: request.toDictionary()) { result in
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}
