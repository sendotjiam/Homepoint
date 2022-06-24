//
//  DetailViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 21/06/22.
//

import Foundation
import RxSwift
import RxRelay

protocol DetailViewModelInput {
    func getProductAndOtherProducts(id: String)
}

protocol DetailViewModelOutput {
    var successGetProduct : PublishSubject<ProductDataModel> { get set }
    var successGetOthersProducts : PublishSubject<[ProductDataModel]> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class DetailViewModel :
    DetailViewModelInput,
    DetailViewModelOutput {
    private let useCase : ProductsUseCase
    
    init(_ useCase : ProductsUseCase = ProductsUseCase(ProductsRepository())) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var successGetProduct = PublishSubject<ProductDataModel>()
    var successGetOthersProducts = PublishSubject<[ProductDataModel]>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func getProductAndOtherProducts(id: String) {
        let group = DispatchGroup()
        isLoading.accept(true)
        group.enter()
        useCase.getProduct(by: id) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200 OK" {
                    self.successGetProduct.onNext(result.data[0])
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            group.leave()
        }
        
        group.enter()
        useCase.getProducts(type: .latest) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    self.successGetOthersProducts.onNext(result.data)
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
            print("Finish Fetching Detail")
        }
    }
}
