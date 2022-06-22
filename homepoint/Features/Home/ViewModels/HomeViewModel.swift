//
//  HomeViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 20/06/22.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    func getProducts()
}

protocol HomeViewModelOutput {
    var successLatestProducts : PublishSubject<[ProductDataModel]> { get set }
    var successDiscountProducts : PublishSubject<[ProductDataModel]> { get set }
    var successAllProducts : PublishSubject<[ProductDataModel]> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class HomeViewModel : HomeViewModelInput, HomeViewModelOutput {
    
    private let useCase : ProductsUseCase
    
    init(_ useCase : ProductsUseCase = ProductsUseCase(ProductsRepository())) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var successLatestProducts = PublishSubject<[ProductDataModel]>()
    var successDiscountProducts = PublishSubject<[ProductDataModel]>()
    var successAllProducts = PublishSubject<[ProductDataModel]>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func getProducts() {
        isLoading.accept(true)
        let group = DispatchGroup()
        group.enter()
        useCase.getProducts(
            type: .discount
        ) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    self.successDiscountProducts.onNext(result.data)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            group.leave()
        }
        
        group.enter()
        useCase.getProducts(
            type: .latest
        ) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    self.successLatestProducts.onNext(result.data)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            group.leave()
        }
        
        group.enter()
        useCase.getProducts(
            type: .all
        ) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    self.successAllProducts.onNext(result.data)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            group.leave()
        }
        
        group.notify(queue: .global()) {
            self.isLoading.accept(false)
            print("Finish Fetching Home")
        }
    }
}
