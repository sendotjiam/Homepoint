//
//  RegisterViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 15/06/22.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

protocol RegisterViewModelInput {
    func register(model : RegisterRequestModel)
}

protocol RegisterViewModelOutput {
    var successRegister : PublishSubject<RegisterResponseModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class RegisterViewModel : RegisterViewModelInput, RegisterViewModelOutput {
    private let useCase : UserUseCase
    
    init(_ useCase : UserUseCase = UserUseCase(UserRepository())) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var successRegister = PublishSubject<RegisterResponseModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func register(model : RegisterRequestModel) {
        isLoading.accept(true)
        useCase.register(request: model) { [weak self] (result, error) in
            guard let self = self else { return }
            self.isLoading.accept(false)
            if let result = result {
                if result.success || result.status == "200 OK" {
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
