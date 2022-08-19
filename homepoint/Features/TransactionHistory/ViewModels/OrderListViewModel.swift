//
//  OrderListViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 27/07/22.
//

import Foundation
import RxSwift
import RxRelay

protocol OrderListViewModelInput {
    func getAllTransactions(userId: String) -> Disposable
}

protocol OrderListViewModelOutput {
    var successGetAllTransactions: PublishSubject<([TransactionDataModel])> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class OrderListViewModel :
    OrderListViewModelInput,
    OrderListViewModelOutput {
    
    private let useCase : TransactionUseCase
    
    init(_ useCase : TransactionUseCase = TransactionUseCase(TransactionRepository())) {
        self.useCase = useCase
    }
    
    var successGetAllTransactions = PublishSubject<([TransactionDataModel])>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    func getAllTransactions(userId: String) -> Disposable {
        isLoading.accept(true)
        return useCase
            .fetchTransactions(userId: userId)
            .subscribe {
                self.successGetAllTransactions.onNext($0.data)
            } onError: {
                self.error.onNext($0.localizedDescription)
            } onCompleted: {
                self.isLoading.accept(false)
            }
    }
    
}
