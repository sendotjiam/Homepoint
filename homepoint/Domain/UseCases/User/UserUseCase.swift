//
//  LoginUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation

protocol UserUseCaseProvider {
    typealias GetUserById = ((UsersResponseModel?, Error?) -> Void)
    
    func login(
        request: LoginRequestModel,
        completion: @escaping ((LoginResponseModel?, Error?) -> ())
    )
    func register(
        request: RegisterRequestModel,
        completion: @escaping ((RegisterResponseModel?, Error?) -> ())
    )
    func getUser(
        by id: String,
        completion: @escaping GetUserById 
    )

    func forget(
        request: ForgetRequestModel,
        completion: @escaping ((ForgetResponseModel?, Error?) -> ())
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

    func getUser(
        by id: String,
        completion: @escaping GetUserById
    ) {
        repository.getUser(by: id) { result, error in
            completion(result, error)
        }
    }
    func forget(
        request: ForgetRequestModel,
        completion: @escaping ((ForgetResponseModel?, Error?) -> ())
    ) {
        repository.forget(params: request.toDictionary()) { (result, error) in
            completion(result, error)
        }
    }

}
