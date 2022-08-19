//
//  SearchViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 22/06/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol SearchViewModelInput {
    func search(params: [String : Any], type : SearchType)
}

protocol SearchViewModelOutput {
    var successAllProducts : PublishSubject<AllProductsDataModel> { get set }
    var successProductsData : PublishSubject<[ProductDataModel]> { get set }
    var error : PublishSubject<String> { get set } 
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class SearchViewModel :
    SearchViewModelInput,
    SearchViewModelOutput {
    
    private let useCase : ProductsUseCase
    
    init(_ useCase : ProductsUseCase = ProductsUseCase(ProductsRepository())) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var successAllProducts = PublishSubject<AllProductsDataModel>()
    var successProductsData = PublishSubject<[ProductDataModel]>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func search(params: [String : Any], type : SearchType) {
        isLoading.accept(true)
        switch type {
        case .normal:
            useCase.getProducts(params: params) { [weak self] result, error in
                guard let self = self else { return }
                self.isLoading.accept(false)
                if let result = result {
                    if result.success || result.status == "200 OK" {
                        self.successAllProducts.onNext(result.data)
                    } else {
                        self.error.onNext(result.message)
                    }
                } else {
                    self.error.onNext(error?.localizedDescription ?? "ERROR")
                }
            }
        case .bestOffer:
            useCase.getProducts(
                type: .discount
            ) { [weak self] result, error in
                guard let self = self else { return }
                self.isLoading.accept(false)
                if let result = result {
                    if result.success || result.status == "200" {
                        self.successProductsData.onNext(result.data)
                    } else {
                        self.error.onNext(result.message)
                    }
                } else {
                    self.error.onNext(error?.localizedDescription ?? "ERROR")
                }
            }
        case .recommendation:
            useCase.getProducts(
                type: .latest
            ) { [weak self] result, error in
                guard let self = self else { return }
                self.isLoading.accept(false)
                if let result = result {
                    if result.success || result.status == "200" {
                        self.successProductsData.onNext(result.data)
                    } else {
                        self.error.onNext(result.message)
                    }
                } else {
                    self.error.onNext(error?.localizedDescription ?? "ERROR")
                }
            }
        }
    }
    
}
