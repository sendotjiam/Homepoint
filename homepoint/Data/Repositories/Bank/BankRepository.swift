//
//  BankRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

final class BankRepository {
    private let urlString = "api/v1/bank"
    
    private let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension BankRepository : BankRepositoryInterface {
    func fetchBanks() -> Bank {
        Observable.create { observer in
            self.apiClient.request(
                self.urlString,
                .get,
                nil,
                [:]
            ) { response, data, error in
                let parsed = RepositoryManager.shared.parse(data: data)
                if let jsonArr = parsed.json {
                    var model = [BankResponseModel]()
                    jsonArr.forEach { str, json in
                        model.append(BankResponseModel(object: json))
                    }
                    observer.onNext(model)
                    observer.onCompleted()
                } else {
                    observer.onError(parsed.error!)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
