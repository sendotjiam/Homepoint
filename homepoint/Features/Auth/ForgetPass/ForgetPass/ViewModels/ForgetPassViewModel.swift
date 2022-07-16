//
//  ForgetPassViewModel.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 14/07/22.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

protocol ForgetViewModelInput {
    func forget(model : ForgetRequestModel)
}

protocol ForgetViewModelOutput {
    var successForget : PublishSubject<ForgetResponseModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class ForgetViewModel : ForgetViewModelInput, ForgetViewModelOutput {
    private let useCase : UserUseCase

    init(_ useCase : UserUseCase = UserUseCase(UserRepository())) {
        self.useCase = useCase
    }

    // MARK: - Output
    var successForget = PublishSubject<ForgetResponseModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)

    // MARK: - Input
    func forget(model : ForgetRequestModel) {
        isLoading.accept(true)
        useCase.forget(request: model) { [weak self] (result, error) in
            guard let self = self else { return }
            self.isLoading.accept(false)
            if let result = result {
                if result.success && result.status == "200" {
                    self.successForget.onNext(result)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
        }
    }
}

