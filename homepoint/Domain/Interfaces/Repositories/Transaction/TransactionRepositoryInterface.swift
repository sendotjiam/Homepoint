//
//  TransactionRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

protocol TransactionRepositoryInterface {
    typealias Transaction = Observable<(TransactionResponseModel)>
    func createTransaction(params: [String: Any]) -> Transaction
    func uploadPaymentProof(id: String, imageData: Data) -> Transaction
    func fetchTransactions(userId: String) -> Transaction
}
