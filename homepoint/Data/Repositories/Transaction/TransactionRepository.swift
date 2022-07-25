//
//  TransactionRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift
import Alamofire

final class TransactionRepository {
    private let urlString = "api/v1/transaction"
    
    private let apiClient : ApiClient
    
    init(_ apiClient : ApiClient = AFApiClient()) {
        self.apiClient =  apiClient
    }
}

extension TransactionRepository : TransactionRepositoryInterface {
    func createTransaction(params: [String : Any]) -> Transaction {
        Observable.create { observer in
            self.apiClient.request(
                self.urlString,
                .post,
                params,
                [:]
            ) { response, data, error in
                let parsed = RepositoryManager.shared.parse(data: data)
                if let json = parsed.json {
                    let model = TransactionResponseModel(object: json)
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
    
//    func uploadPaymentProof(imageData: Data) -> Transaction {
//        AF.upload(multipartFormData: { <#MultipartFormData#> in
//            <#code#>
//        }, to: <#T##URLConvertible#>)
//        let headers : HTTPHeaders = [ "Content-Type" : "multipart/form-data"]
//        return Observable.create { observer in
//            self.apiClient.request(
//                self.urlString + "/\(id)",
//                .put,
//                params,
//                headers
//            ) { response, data, error in
//                let parsed = RepositoryManager.shared.parse(data: data)
//                if let json = parsed.json {
//                    let model = TransactionResponseModel(object: json)
//                    observer.onNext(model)
//                    observer.onCompleted()
//                } else {
//                    observer.onError(parsed.error!)
//                    observer.onCompleted()
//                }
//            }
//            return Disposables.create()
//        }
//    }
}
