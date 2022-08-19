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
    func addWishlist(userId: String, productId: String)
    func checkProductIsWishlist(userId: String, productId: String)
    func deleteWishlist(id: String)
    func addToCart(userId: String, productId: String, qty: Int)
}

protocol DetailViewModelOutput {
    var successGetProduct : PublishSubject<ProductDataModel> { get set }
    var successGetOthersProducts : PublishSubject<[ProductDataModel]> { get set }
    var successAddWishlist : PublishSubject<WishlistDataModel> { get set }
    var successAddToCart : PublishSubject<CartDataModel> { get set }
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
    private let cartUseCase : CartUseCase
    
    init(
        _ productUseCase : ProductsUseCase = ProductsUseCase(ProductsRepository()),
        _ wishlistUseCase : WishlistUseCase = WishlistUseCase(WishlistRepository()),
        _ cartUseCase : CartUseCase = CartUseCase(CartRepository())
    ) {
        self.productUseCase = productUseCase
        self.wishlistUseCase = wishlistUseCase
        self.cartUseCase = cartUseCase
    }
    
    // MARK: - Output
    var successGetProduct = PublishSubject<ProductDataModel>()
    var successGetOthersProducts = PublishSubject<[ProductDataModel]>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    var successIsWishlist = BehaviorRelay<String>(value: "")
    var successAddWishlist = PublishSubject<WishlistDataModel>()
    var successDeleteWishlist = PublishSubject<WishlistDataModel>()
    var successAddToCart = PublishSubject<CartDataModel>()
    
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
    
    func checkProductIsWishlist(userId: String, productId: String) {
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
    
    func addWishlist(userId: String, productId: String) {
        isLoading.accept(true)
        wishlistUseCase.addWishlist(
            productId: productId,
            userId: userId
        ) { result, error in
            if let result = result {
                if result.success || result.status == "200" {
                    guard let result = result.data.first else { return }
                    self.successAddWishlist.onNext(result)
                    self.successIsWishlist.accept(result.id)
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
        isLoading.accept(true)
        wishlistUseCase.deleteWishlist(id: id) { result, error in
            if let result = result {
                if result.success || result.status == "200" {
                    guard let result = result.data.first else { return }
                    self.successAddWishlist.onNext(result)
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
    
    func addToCart(userId: String, productId: String, qty: Int) {
        isLoading.accept(true)
        cartUseCase.addCart(userId: userId, productId: productId, qty: qty) { result, error in
            if let result = result {
                if result.success || result.status == "200" {
                    guard let data = result.data.first else { return }
                    self.successAddToCart.onNext(data)
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
