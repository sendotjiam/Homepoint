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
    func loadTransactionView() -> Disposable
}

protocol TransactionViewModelOutput {
    var successCreateTransaction : PublishSubject<TransactionDataModel> { get set }
    var successLoadTransactionView: PublishSubject<([BankResponseModel], [ShippingResponseModel], AddressDataModel)> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class TransactionViewModel :
    TransactionViewModelInput,
    TransactionViewModelOutput{
    
    private let transactionUseCase : TransactionUseCase
    private let bankUseCase : BankUseCase
    private let shippingUseCase : ShippingUseCase
    private let addressUseCase : AddressUseCase
    
    init(
        _ transactionUseCase : TransactionUseCase = TransactionUseCase(TransactionRepository()),
        _ bankUseCase : BankUseCase = BankUseCase(BankRepository()),
        _ shippingUseCase : ShippingUseCase = ShippingUseCase(ShippingRepository()),
        _ addressUseCase : AddressUseCase = AddressUseCase(AddressRepository())
    ) {
        self.transactionUseCase = transactionUseCase
        self.bankUseCase = bankUseCase
        self.shippingUseCase = shippingUseCase
        self.addressUseCase = addressUseCase
    }
    
    // MARK: - Output
    var successCreateTransaction = PublishSubject<TransactionDataModel>()
    var successLoadTransactionView = PublishSubject<([BankResponseModel], [ShippingResponseModel], AddressDataModel)>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func loadTransactionView() -> Disposable {
        /// Mock Address Id
        let addressId = "29bb4153-b2f0-461f-8707-29aa059272a7"
        isLoading.accept(true)
        return Observable.zip(
            bankUseCase.fetchBanks().catchErrorJustReturn([]),
            shippingUseCase.fetchShipping().catchErrorJustReturn([]),
            addressUseCase.getAddress(by: addressId)
        ).subscribe { [weak self] in
            self?.successLoadTransactionView.onNext($0)
            self?.isLoading.accept(false)
        } onError: { [weak self] in
            self?.error.onNext($0.localizedDescription)
            self?.isLoading.accept(false)
        }
    }
    
    func createTransaction(request: TransactionRequestModel) -> Disposable {
        isLoading.accept(true)
        return transactionUseCase
            .createTransaction(params: request.toDictionary())
            .subscribe { [weak self] in
                if $0.success || $0.status == "200 OK" {
                    self?.successCreateTransaction.onNext($0.data.first!)
                } else { self?.error.onNext($0.message) }
            } onError: { [weak self] in
                self?.error.onNext($0.localizedDescription)
            } onCompleted: { [weak self] in
                self?.isLoading.accept(false)
            }
    }
}
