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
        "{ \"message\": \"Token for Login\", \"status\": \"200\", \"success\": true, \"data\": { \"token\": \"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZW5kbzFAbWFpbC5jb20iLCJleHAiOjE2NTUyMjA3OTMsImlhdCI6MTY1NTIxNDc5M30.-k4BDV5qHvYI-IaItSoVyL6LPxp_9MclkuwDhacH2NA\", \"name\": \"Sendo\", \"id\": \"3e714161-1e1e-4b6d-b78e-32f1bb072e26\"} }".data(using: .utf8)

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
            "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZW5kbzFAbWFpbC5jb20iLCJleHAiOjE2NTUyMjA3OTMsImlhdCI6MTY1NTIxNDc5M30.-k4BDV5qHvYI-IaItSoVyL6LPxp_9MclkuwDhacH2NA",
            "name": "Sendo",
            "id": "3e714161-1e1e-4b6d-b78e-32f1bb072e26"

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
    
    static func generateUsersData() -> Data? {
        "{\"success\":true,\"status\":\"200\",\"message\":\"Success For Get User from Id\",\"data\":{\"id\":\"a1a22a38-7a2d-4ee8-bd12-20ddd91e3c0c\",\"addresses\":[],\"name\":\"tika\",\"phoneNumber\":null,\"email\":\"tika@gmail.com\",\"password\":\"$2a$10$HuxJVJZ1iw16phWhPvJA0.6je0G07cpwebJCqyNDEtSHRrH5HfKlu\",\"roles\":\"ROLE_CUSTOMER\",\"joinedSince\":\"2022-07-13T13:51:57.684+00:00\",\"birthDate\":null,\"gender\":null,\"isActive\":false}}".data(using: .utf8)
    }
    
    static func generateRegisterDataModel() -> RegisterDataModel {
        RegisterDataModel(object: JSON([
            "email": "sendo@mail.com",
            "name": "sendo",
            "password": "12345"
        ]))
    }
    
    static func generateUsersDataModel() -> [UsersDataModel] {
        [
            UsersDataModel(object: JSON([
                "id": "a1a22a38-7a2d-4ee8-bd12-20ddd91e3c0c",
                "name": "tika",
                "phoneNumber": "",
                "email": "tika@gmail.com",
                "birthDate": "",
                "gender": ""
            ]))
        ]
    }


    static func generateForgetData() -> Data? {
        "{ \"message\": \"Success For Forget\", \"status\": \"200\", \"success\": true, \"data\": { \"email\": \"tommy@mail.com\" } }".data(using: .utf8)
    }

    static func generateForgetResponseModel() -> ForgetResponseModel {
        ForgetResponseModel(object: JSON([
            "success": true,
            "status": "200",
            "message": "Success For Forget",
            "data": ""
        ]))
    }

    static func generateForgetDataModel() -> ForgetDataModel {
        ForgetDataModel(object: JSON([
            "email": "tommy@mail.com",
        ]))
    }

}
