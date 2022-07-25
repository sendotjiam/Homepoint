//
//  AddressUseCase.swift
//  homepoint
//
//  Created by Kartika on 25/07/22.
//

import Foundation

protocol AddressUseCaseProvider {
    typealias AddressCompletion = ((AddressResponseModel?, Error?) -> Void)
    
    func AddAddress(
        request: [String: Any],
        completion: @escaping AddressCompletion
    )
        
}

final class AddressUseCase {
    private let repository : AddressRepositoryInterface
    
    init(_ repository : AddressRepositoryInterface) {
        self.repository = repository
    }
}

extension AddressUseCase : AddressUseCaseProvider {
    func AddAddress(request: [String : Any], completion: @escaping AddressCompletion) {
        repository.addAddress(params: request) { result, error in
            completion(result, error)
        }
    }
}
