//
//  CartViewModel.swift
//  homepoint
//
//  Created by Sendo Tjiam on 09/07/22.
//

import Foundation
import RxSwift
import RxRelay

protocol CartViewModelInput {
    func getCarts(userId: String)
    func deleteCartItem(id: String)
    func updateCartItem(id: String, qty: Int)
}

protocol CartViewModelOutput {
    var successFetchCarts : PublishSubject<[CartDataModel]> { get set }
    var successDeleteCart : PublishSubject<[CartDataModel]> { get set }
    var successUpdateCart : PublishSubject<[CartDataModel]> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class CartViewModel : CartViewModelInput, CartViewModelOutput {
    
    private let useCase : CartUseCase
    
    init(_ useCase : CartUseCase = CartUseCase(CartRepository())) {
        self.useCase = useCase
    }
    
    var successFetchCarts = PublishSubject<[CartDataModel]>()
    var successDeleteCart = PublishSubject<[CartDataModel]>()
    var successUpdateCart = PublishSubject<[CartDataModel]>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    func getCarts(userId: String) {
        isLoading.accept(true)
        useCase.fetchCarts(userId: userId) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    if let data = result.data.first?.id, data == "" {
                        self.successFetchCarts.onNext([])
                    } else { self.successFetchCarts.onNext(result.data) }
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            self.isLoading.accept(false)
        }
    }
    
    func deleteCartItem(id: String) {
        isLoading.accept(true)
        useCase.deleteCart(id: id) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    self.successDeleteCart.onNext(result.data)
                } else {
                    self.error.onNext(result.message)
                }
            } else {
                self.error.onNext(error?.localizedDescription ?? "ERROR")
            }
            self.isLoading.accept(false)
        }
    }
    
    func updateCartItem(id: String, qty: Int) {
        isLoading.accept(true)
        let params : [String: Any] = [
            "id": id,
            "quantity": qty
        ]
        useCase.updateCart(params: params) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200" {
                    self.successUpdateCart.onNext(result.data)
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
