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
    func addWishlist(productId: String)
}

protocol DetailViewModelOutput {
    var successGetProduct : PublishSubject<ProductDataModel> { get set }
    var successGetOthersProducts : PublishSubject<[ProductDataModel]> { get set }
    var successAddWishlist : PublishSubject<WishlistDataModel> { get set }
    var isWishlist : PublishSubject<Bool> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class DetailViewModel :
    DetailViewModelInput,
    DetailViewModelOutput {
    private let productUseCase : ProductsUseCase
    private let wishlistUseCase : WishlistUseCase
    
    init(
        _ productUseCase : ProductsUseCase = ProductsUseCase(ProductsRepository()),
        _ wishlistUseCase : WishlistUseCase = WishlistUseCase(WishlistRepository())
    ) {
        self.productUseCase = productUseCase
        self.wishlistUseCase = wishlistUseCase
    }
    
    // MARK: - Output
    var successGetProduct = PublishSubject<ProductDataModel>()
    var successGetOthersProducts = PublishSubject<[ProductDataModel]>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var isWishlist = PublishSubject<Bool>()
    var successAddWishlist = PublishSubject<WishlistDataModel>()
    
    // MARK: - Input
    func getProductAndOtherProducts(id: String) {
        let group = DispatchGroup()
        isLoading.accept(true)
        group.enter()
        productUseCase.getProduct(by: id) { [weak self] result, error in
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
        productUseCase.getProducts(type: .latest) { [weak self] result, error in
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
    
    func addWishlist(productId: String) {
        // Mock
        let userId = "0d9cb9e6-0328-453e-a6d1-0457de2c9d9d"
        isLoading.accept(true)
        wishlistUseCase.addWishlist(
            productId: productId,
            userId: userId
        ) { result, error in
            if let result = result {
                if result.success || result.status == "200" {
                    self.successAddWishlist.onNext(result.data)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            self.isLoading.accept(false)
        }
    }
}
