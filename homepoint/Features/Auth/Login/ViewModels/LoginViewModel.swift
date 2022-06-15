//
//  LoginViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 15/06/22.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

protocol LoginViewModelInput {
    func login(model : LoginRequestModel)
}

protocol LoginViewModelOutput {
    var successLogin : PublishSubject<LoginResponseModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class LoginViewModel : LoginViewModelInput, LoginViewModelOutput {
    private let useCase : UserUseCase
    
    init(_ useCase : UserUseCase = UserUseCase(UserRepository())) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var successLogin = PublishSubject<LoginResponseModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func login(model : LoginRequestModel) {
        isLoading.accept(true)
        useCase.login(request: model) { [weak self] (result, error) in
            guard let self = self else { return }
            self.isLoading.accept(false)
            if let result = result {
                if result.success && result.status == "200" {
                    self.saveToken(token: result.data.token)
                    self.successLogin.onNext(result)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
        }
    }
    
    private func saveToken(token: String) {
        print("PREV TOKEN", UserDefaults.standard.string(forKey: "user_token"))
        UserDefaults.standard.setValue(token, forKey: "user_token")
    }
}
