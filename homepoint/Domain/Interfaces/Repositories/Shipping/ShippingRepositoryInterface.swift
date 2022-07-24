//
//  ShippingRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

protocol ShippingRepositoryInterface {
    typealias Shipping = Observable<([ShippingResponseModel])>
    func fetchShipping() -> Shipping
}
