//
//  ShippingRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

final class ShippingRepository {
    private let urlString = "api/v1/shippingservice"
    
    private let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient = apiClient
    }
}

extension ShippingRepository : ShippingRepositoryInterface {
    func fetchShipping() -> Shipping {
        Observable.create { observer in
            self.apiClient.request(
                self.urlString,
                .get,
                nil,
                [:]
            ) { response, data, error in
                let parsed = RepositoryManager.shared.parse(data: data)
                if let jsonArr = parsed.json {
                    var model = [ShippingResponseModel]()
                    jsonArr.forEach { str, json in
                        model.append(ShippingResponseModel(object: json))
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
