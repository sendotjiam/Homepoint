//
//  TransactionUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

protocol TransactionUseCaseProvider {
    func createTransaction(params: [String: Any]) -> Observable<(TransactionResponseModel)>
    func uploadPaymentProof(id: String, imageData: Data) -> Observable<(TransactionResponseModel)>
    func fetchTransactions(userId: String) -> Observable<(TransactionResponseModel)>
}


final class TransactionUseCase {
    private let repository : TransactionRepositoryInterface
    
    init(_ repository : TransactionRepositoryInterface = TransactionRepository()) {
        self.repository = repository
    }
}

extension TransactionUseCase : TransactionUseCaseProvider {
    func uploadPaymentProof(id: String, imageData: Data) -> Observable<(TransactionResponseModel)> {
        repository.uploadPaymentProof(id: id, imageData: imageData)
    }
    
    func fetchTransactions(userId: String) -> Observable<(TransactionResponseModel)> {
        repository.fetchTransactions(userId: userId)
    }
    
    func createTransaction(params: [String: Any]) -> Observable<(TransactionResponseModel)> {
        repository.createTransaction(params: params)
    }
}
