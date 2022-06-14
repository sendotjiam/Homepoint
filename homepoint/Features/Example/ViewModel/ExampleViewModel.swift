//
//  ExampleViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

protocol ExampleViewModelInput {
    func login(model : LoginRequestModel)
    func register(model : RegisterRequestModel)
}

protocol ExampleViewModelOutput {
    var successLogin : PublishSubject<LoginResponseModel> { get set }
    var successRegister : PublishSubject<RegisterResponseModel> { get set }
    var error : PublishSubject<String> { get set }
}

final class ExampleViewModel: ExampleViewModelInput, ExampleViewModelOutput {

    private let useCase : UserUseCase
    
    init(_ useCase : UserUseCase = UserUseCase(UserRepository())) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var successLogin = PublishSubject<LoginResponseModel>()
    var successRegister = PublishSubject<RegisterResponseModel>()
    var error = PublishSubject<String>()
    
    // MARK: - Input
    func login(model : LoginRequestModel) {
        useCase.login(request: model) { [weak self] (result, error) in
            guard let self = self else { return }
            if let result = result {
                if result.success && result.status == "200" {
                    self.successLogin.onNext(result)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
        }
    }
    
    func register(model : RegisterRequestModel) {
        useCase.register(request: model) { [weak self] (result, error) in
            guard let self = self else { return }
            if let result = result {
                if result.success && result.status == "200" {
                    self.successRegister.onNext(result)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
        }
    }
    
}
