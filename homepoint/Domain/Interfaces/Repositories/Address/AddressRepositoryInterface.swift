//
//  AddressRepositoryInterface.swift
//  homepoint
//
//  Created by Kartika on 25/07/22.
//

import Foundation

protocol AddressRepositoryInterface {
    typealias AddressCompletion = ((AddressResponseModel?, Error?) -> Void)
    
    func addAddress(params: [String: Any], completion: @escaping AddressCompletion)
}
