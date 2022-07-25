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
//    func uploadPaymentProof(imageData: Data) -> Observable<(TransactionResponseModel)>
}


final class TransactionUseCase {
    private let repository : TransactionRepositoryInterface
    
    init(_ repository : TransactionRepositoryInterface = TransactionRepository()) {
        self.repository = repository
    }
}

extension TransactionUseCase : TransactionUseCaseProvider {
//    func uploadPaymentProof(imageData: Data) -> Observable<(TransactionResponseModel)> {
//        <#code#>
//    }
    
    func createTransaction(params: [String: Any]) -> Observable<(TransactionResponseModel)> {
        repository.createTransaction(params: params)
    }
}
