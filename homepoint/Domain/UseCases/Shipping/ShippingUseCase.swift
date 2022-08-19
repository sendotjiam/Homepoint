//
//  ShippingUseCase.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

protocol ShippingUseCaseProvider {
    func fetchShipping() -> Observable<([ShippingResponseModel])>
}

final class ShippingUseCase {
    private let repository : ShippingRepositoryInterface

    init(_ repository : ShippingRepositoryInterface = ShippingRepository()) {
        self.repository = repository
    }
}

extension ShippingUseCase : ShippingUseCaseProvider {
    func fetchShipping() -> Observable<([ShippingResponseModel])> {
        return repository.fetchShipping()
    }
}
