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
    func checkProductIsWishlist(productId: String)
    func deleteWishlist(id: String)
}

protocol DetailViewModelOutput {
    var successGetProduct : PublishSubject<ProductDataModel> { get set }
    var successGetOthersProducts : PublishSubject<[ProductDataModel]> { get set }
    var successAddWishlist : PublishSubject<WishlistDataModel> { get set }
    var successIsWishlist : BehaviorRelay<String> { get set }
    var successDeleteWishlist : PublishSubject<WishlistDataModel> {get set }
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
    var successIsWishlist = BehaviorRelay<String>(value: "")
    var successAddWishlist = PublishSubject<WishlistDataModel>()
    var successDeleteWishlist = PublishSubject<WishlistDataModel>()
    
    // MARK: - Input
    func getProductAndOtherProducts(id: String) {
        isLoading.accept(true)
        let group = DispatchGroup()
        
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
    
    func checkProductIsWishlist(productId: String) {
        // Mock
        let userId = "0d9cb9e6-0328-453e-a6d1-0457de2c9d9d"
        isLoading.accept(true)
        wishlistUseCase.checkProductIsWishlist(
            productId: productId, userId: userId
        ) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                self.successIsWishlist.accept(result)
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            self.isLoading.accept(false)
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
                    self.successIsWishlist.accept(result.data.id)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            self.isLoading.accept(false)
        }
    }
    
    func deleteWishlist(id: String) {
        // Mock
        isLoading.accept(true)
        wishlistUseCase.deleteWishlist(id: id) { result, error in
            if let result = result {
                if result.success || result.status == "200" {
                    self.successDeleteWishlist.onNext(result.data)
                    self.successIsWishlist.accept("")
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
