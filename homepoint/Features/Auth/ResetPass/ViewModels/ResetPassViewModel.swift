//
//  ResetPassViewModel.swift
//  homepoint
//
//  Created by Tommy Yon Prakoso on 14/07/22.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

protocol ResetViewModelInput {
    func reset(model : ResetRequestModel)
}

protocol ResetViewModelOutput {
    var successReset : PublishSubject<ResetResponseModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class ResetViewModel : ResetViewModelInput, ResetViewModelOutput {
    private let useCase : UserUseCase

    init(_ useCase : UserUseCase = UserUseCase(UserRepository())) {
        self.useCase = useCase
    }

    // MARK: - Output
    var successReset = PublishSubject<ResetResponseModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)

    // MARK: - Input
    func reset(model : ResetRequestModel) {
        isLoading.accept(true)
        useCase.reset(request: model) { [weak self] (result, error) in
            guard let self = self else { return }
            self.isLoading.accept(false)
            if let result = result {
                if result.success && result.status == "200" {
                    self.successReset.onNext(result)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
        }
    }
}
