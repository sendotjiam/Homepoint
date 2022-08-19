//
//  BankUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

protocol BankUseCaseProvider {
    func fetchBanks() -> Observable<([BankResponseModel])>
}


final class BankUseCase {
    private let repository : BankRepositoryInterface
    
    init(_ repository : BankRepositoryInterface = BankRepository()) {
        self.repository = repository
    }
}

extension BankUseCase : BankUseCaseProvider {
    func fetchBanks() -> Observable<([BankResponseModel])> {
        return repository.fetchBanks()
    }
}

