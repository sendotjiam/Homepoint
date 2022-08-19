//
//  BankRepositoryInterface.swift
//  homepoint
//
//  Created by Sendo Tjiam on 24/07/22.
//

import Foundation
import RxSwift

protocol BankRepositoryInterface {
    typealias Bank = Observable<([BankResponseModel])>
    func fetchBanks() -> Bank
}
