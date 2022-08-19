//
//  ConfirmTransactionViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/07/22.
//

import Foundation
import RxSwift
import RxRelay

protocol ConfirmTransactionViewModelInput {
    func uploadPaymentProof(id: String, imageData: Data) -> Disposable
}

protocol ConfirmTransactionViewModelOutput {
    var successUploadProof : PublishSubject<TransactionDataModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class ConfirmTransactionViewModel :
    ConfirmTransactionViewModelInput,
    ConfirmTransactionViewModelOutput{
    
    private let useCase : TransactionUseCase
    
    init(_ useCase : TransactionUseCase = TransactionUseCase(TransactionRepository())) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var successUploadProof = PublishSubject<TransactionDataModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func uploadPaymentProof(id: String, imageData: Data) -> Disposable {
        isLoading.accept(true)
        return useCase
            .uploadPaymentProof(id: id, imageData: imageData)
            .subscribe { [weak self] in
                guard let data = $0.data.first else { return }
                self?.successUploadProof.onNext(data)
            } onError: { [weak self] in
                self?.error.onNext($0.localizedDescription)
            } onCompleted: { [weak self] in
                self?.isLoading.accept(false)
            }
        
    }
}
