//
//  NetworkError.swift
//  homepoint
//
//  Created by Sendo Tjiam on 14/06/22.
//

import Foundation

enum NetworkError : Error {
    case ApiError
}

enum AuthError : Error {
    case FailedLogin
    case FailedRegister
}
