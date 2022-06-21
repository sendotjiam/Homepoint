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
    static func generateLoginData() -> Data? {
        "{ \"message\": \"Token for Login\", \"status\": \"200\", \"success\": true, \"data\": { \"token\": \"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZW5kbzFAbWFpbC5jb20iLCJleHAiOjE2NTUyMjA3OTMsImlhdCI6MTY1NTIxNDc5M30.-k4BDV5qHvYI-IaItSoVyL6LPxp_9MclkuwDhacH2NA\"} }".data(using: .utf8)
    }
    
    static func generateLoginResponseModel() -> LoginResponseModel {
        LoginResponseModel(object: JSON([
            "message": "Token for Login",
            "status": "200",
            "success": true,
            "data": ""
        ]))
    }
    
    static func generateLoginDataModel() -> LoginDataModel {
        LoginDataModel(object: JSON([
            "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZW5kbzFAbWFpbC5jb20iLCJleHAiOjE2NTUyMjA3OTMsImlhdCI6MTY1NTIxNDc5M30.-k4BDV5qHvYI-IaItSoVyL6LPxp_9MclkuwDhacH2NA"
        ]))
    }
    
    static func generateRegisterData() -> Data? {
        "{ \"message\": \"Success For Register\", \"status\": \"200\", \"success\": true, \"data\": { \"name\": \"sendo\", \"email\": \"sendo@mail.com\", \"password\": \"12345\" } }".data(using: .utf8)
    }
    
    static func generateRegisterResponseModel() -> RegisterResponseModel {
        RegisterResponseModel(object: JSON([
            "success": true,
            "status": "200",
            "message": "Success For Register",
            "data": ""
        ]))
    }
    
    static func generateRegisterDataModel() -> RegisterDataModel {
        RegisterDataModel(object: JSON([
            "email": "sendo@mail.com",
            "name": "sendo",
            "password": "12345"
        ]))
    }
}
