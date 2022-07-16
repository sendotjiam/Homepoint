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
}

protocol WishlistViewModelOutput {
    var successGetWishlists : PublishSubject<[WishlistDataModel]> { get set }
    var successDeleteWishlist : PublishSubject<WishlistDataModel> { get set }
    var successUpdateWishlist : PublishSubject<WishlistDataModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class WishlistViewModel :
    WishlistViewModelInput,
    WishlistViewModelOutput {

    private let useCase : WishlistUseCase
    
    init(_ useCase : WishlistUseCase = WishlistUseCase(WishlistRepository())) {
        self.useCase = useCase
    }
    
    var successGetWishlists = PublishSubject<[WishlistDataModel]>()
    var successDeleteWishlist = PublishSubject<WishlistDataModel>()
    var successUpdateWishlist = PublishSubject<WishlistDataModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    func getWishlists(userId : String) {
        if userId == "" { return }
        isLoading.accept(true)
        useCase.fetchWishlists(userId: userId) {
            [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
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
        useCase.deleteWishlist(id: id) {
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
    
}
