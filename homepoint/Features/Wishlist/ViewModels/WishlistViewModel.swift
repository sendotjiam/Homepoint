//
//  WishlistViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 12/07/22.
//

import Foundation
import RxSwift
import RxRelay

protocol WishlistViewModelInput {
    func getWishlists(userId : String)
    func deleteWishlist(id: String)
    func updateWishlist(qty: Int)
    func addToCart(userId: String, productId: String, qty: Int)
}

protocol WishlistViewModelOutput {
    var successGetWishlists : PublishSubject<[WishlistDataModel]> { get set }
    var successDeleteWishlist : PublishSubject<WishlistDataModel> { get set }
    var successUpdateWishlist : PublishSubject<WishlistDataModel> { get set }
    var successAddToCart : PublishSubject<CartDataModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class WishlistViewModel :
    WishlistViewModelInput,
    WishlistViewModelOutput {

    private let wishlistUseCase : WishlistUseCase
    private let cartUseCase : CartUseCase
    
    init(
        _ wishlistUseCase : WishlistUseCase = WishlistUseCase(WishlistRepository()),
        _ cartUseCase : CartUseCase = CartUseCase(CartRepository())
    ) {
        self.wishlistUseCase = wishlistUseCase
        self.cartUseCase = cartUseCase
    }
    
    var successGetWishlists = PublishSubject<[WishlistDataModel]>()
    var successDeleteWishlist = PublishSubject<WishlistDataModel>()
    var successUpdateWishlist = PublishSubject<WishlistDataModel>()
    var successAddToCart = PublishSubject<CartDataModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    func getWishlists(userId : String) {
        if userId == "" { return }
        isLoading.accept(true)
        wishlistUseCase.fetchWishlists(userId: userId) {
            [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    print(result)
                    self.successGetWishlists.onNext(result.data.wishlistItems)
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
        wishlistUseCase.deleteWishlist(id: id) {
            [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    self.successDeleteWishlist.onNext(result.data)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
        }
    }
    
    func updateWishlist(qty: Int) {
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
