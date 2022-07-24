//
//  TransactionViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 10/07/22.
//

import Foundation
import RxSwift
import RxRelay

protocol TransactionViewModelInput {
    func createTransaction(request: TransactionRequestModel) -> Disposable
    
    func getBanksAndShipping() -> Disposable
}

protocol TransactionViewModelOutput {
    var successCreateTransaction : PublishSubject<[TransactionDataModel]> { get set }
    var successGetBanksAndShipping: PublishSubject<([BankResponseModel], [ShippingResponseModel])> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class TransactionViewModel :
    TransactionViewModelInput,
    TransactionViewModelOutput{
    
    private let transactionUseCase : TransactionUseCase
    private let bankUseCase : BankUseCase
    private let shippingUseCase : ShippingUseCase
    
    init(
        _ transactionUseCase : TransactionUseCase = TransactionUseCase(TransactionRepository()),
        _ bankUseCase : BankUseCase = BankUseCase(BankRepository()),
        _ shippingUseCase : ShippingUseCase = ShippingUseCase(ShippingRepository())
    ) {
        self.transactionUseCase = transactionUseCase
        self.bankUseCase = bankUseCase
        self.shippingUseCase = shippingUseCase
    }
    
    var successCreateTransaction = PublishSubject<[TransactionDataModel]>()
    var successGetBanksAndShipping = PublishSubject<([BankResponseModel], [ShippingResponseModel])>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    func getBanksAndShipping() -> Disposable {
        isLoading.accept(true)
        return Observable.zip(
            bankUseCase.fetchBanks().catchErrorJustReturn([]),
            shippingUseCase.fetchShipping().catchErrorJustReturn([])
        ).subscribe(onNext: { [weak self] in
            self?.successGetBanksAndShipping.onNext(($0, $1))
            self?.isLoading.accept(false)
        }, onError: { [weak self] in
            self?.error.onNext($0.localizedDescription)
            self?.isLoading.accept(false)
        })
    }
    
    func createTransaction(request: TransactionRequestModel) -> Disposable {
        isLoading.accept(true)
        return transactionUseCase
            .createTransaction(params: request.toDictionary())
            .subscribe { [weak self] in
                self?.successCreateTransaction.onNext($0.data)
            } onError: { [weak self] in
                self?.error.onNext($0.localizedDescription)
            } onCompleted: { [weak self] in
                self?.isLoading.accept(false)
            }
    }
}
