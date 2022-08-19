//
//  AddressUseCase.swift
//  homepoint
//
//  Created by Kartika on 25/07/22.
//

import Foundation
import RxSwift

protocol AddressUseCaseProvider {
    typealias AddressCompletion = ((AddressResponseModel?, Error?) -> Void)
    
    func AddAddress(
        request: [String: Any],
        completion: @escaping AddressCompletion
    )
    
    func getAddress(by id: String) -> Observable<(AddressDataModel)>
        
}

final class AddressUseCase {
    private let repository : AddressRepositoryInterface
    
    init(_ repository : AddressRepositoryInterface) {
        self.repository = repository
    }
}

extension AddressUseCase : AddressUseCaseProvider {
    func getAddress(by id: String) -> Observable<(AddressDataModel)> {
        repository.getAddress(by: id)
    }
    
    func AddAddress(request: [String : Any], completion: @escaping AddressCompletion) {
        repository.addAddress(params: request) { result, error in
            completion(result, error)
        }
    }
}
