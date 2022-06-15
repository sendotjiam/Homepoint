//
//  MockServices.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation
import SwiftyJSON
@testable import homepoint

struct MockUserData {
    static func generateLoginData() -> LoginResponseModel {
        LoginResponseModel(object: JSON([
            "message": "Token for Login",
            "status": "200",
            "success": true,
            "data": LoginDataModel(object: JSON([
                "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZW5kbzFAbWFpbC5jb20iLCJleHAiOjE2NTUyMjA3OTMsImlhdCI6MTY1NTIxNDc5M30.-k4BDV5qHvYI-IaItSoVyL6LPxp_9MclkuwDhacH2NA"
            ]))
        ]))
    }
    
    static func generateRegisterData() -> RegisterResponseModel {
        RegisterResponseModel(object: JSON([
            "message": "Token for Login",
            "status": "200",
            "success": true,
            "data": RegisterDataModel(object: JSON([
                "email": "sendo@mail.com",
                "name": "sendo",
                "password": "12345"
            ]))
        ]))
    }
}

struct MockPositiveUserRepository : UserRepositoryInterface {
    
    func login(
        params: [String : Any],
        completion: @escaping ((LoginResponseModel?, Error?) -> Void)
    ) {
        completion(MockUserData.generateLoginData(), nil)
    }
    
    func register(
        params: [String : Any],
        completion: @escaping ((RegisterResponseModel?, Error?) -> Void)
    ) {
        completion(MockUserData.generateRegisterData(), nil)
    }
}

struct MockNegativeUserRepository : UserRepositoryInterface {
    func login(
        params: [String : Any],
        completion: @escaping ((LoginResponseModel?, Error?) -> Void)
    ) {
        completion(nil, AuthError.FailedLogin)
    }
    
    func register(
        params: [String : Any],
        completion: @escaping ((RegisterResponseModel?, Error?) -> Void)
    ) {
        completion(nil, AuthError.FailedRegister)
    }
    
}
