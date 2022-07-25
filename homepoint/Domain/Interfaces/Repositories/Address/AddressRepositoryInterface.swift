//
//  AddressRepositoryInterface.swift
//  homepoint
//
//  Created by Kartika on 25/07/22.
//

import Foundation
import RxSwift

protocol AddressRepositoryInterface {
    typealias AddressCompletion = ((AddressResponseModel?, Error?) -> Void)
    typealias Address = Observable<(AddressDataModel)>
    
    func addAddress(params: [String: Any], completion: @escaping AddressCompletion)
    func getAddress(by id: String) -> Address
}
