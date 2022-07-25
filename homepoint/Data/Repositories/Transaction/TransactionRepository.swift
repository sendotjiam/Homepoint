//
//  TransactionRepository.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

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
    
    func uploadPaymentProof(id: String, imageData: Data) -> Transaction {
        let headers : HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Accept" : "application/json"
        ]
        let url = Constants.BaseUrl + "\(urlString)/payment-confirmation/\(id)"
        return Observable.create { observer in
            AF.upload(multipartFormData: { multiPart in
                multiPart.append(
                    imageData,
                    withName: "paymentProof",
                    fileName: "file.jpg",
                    mimeType: "image/jpeg"
                )
            }, to: url, method: .put, headers: headers)
                .uploadProgress(queue: .main, closure: { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .response { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let json = try JSON(data.data)
                            let model = TransactionResponseModel(object: json)
                            observer.onNext(model)
                            observer.onCompleted()
                        } catch {
                            observer.onError("TEST" as! Error)
                            observer.onCompleted()
                        }
                    case .failure(let error):
                        observer.onError(error)
                        observer.onCompleted()
                    }
                }
            return Disposables.create()
        }
    }
}
