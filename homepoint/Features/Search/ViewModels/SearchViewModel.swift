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
    func search(params: [String : Any])
}

protocol SearchViewModelOutput {
    var successSearch : PublishSubject<AllProductsDataModel> { get set }
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
    var successSearch = PublishSubject<AllProductsDataModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func search(params: [String : Any]) {
        isLoading.accept(true)
        useCase.getProducts(params: params) { [weak self] result, error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            if let result = result {
                if result.success || result.status == "200 OK" {
                    self.successSearch.onNext(result.data)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
        }
    }
    
}
