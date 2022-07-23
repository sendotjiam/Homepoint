//
//  ProfileViewModel.swift
//  homepoint
//
//  Created by Kartika on 22/07/22.
//

import Foundation
import RxSwift
import RxRelay

protocol ProfileViewModelInput {
    func getUserData(userId: String)
}

protocol ProfileViewModelOutput {
    var successGetUserData : PublishSubject<UserDataModel> { get set }
    var error : PublishSubject<String> { get set }
    var isLoading : BehaviorRelay<Bool> { get set }
}

final class ProfileViewModel :
    ProfileViewModelInput,
    ProfileViewModelOutput {
    private let userUseCase : UserUseCase
    
    init(_ userUseCase : UserUseCase = UserUseCase(UserRepository())) {
        self.userUseCase = userUseCase
    }
    
    // MARK: - Output
    var successGetUserData = PublishSubject<UserDataModel>()
    var error = PublishSubject<String>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Input
    func getUserData(userId: String) {
        isLoading.accept(true)
        
        userUseCase.getUser(by: userId) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                if result.success || result.status == "200 OK" {
                    self.successGetUserData.onNext(result.data[0])
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
