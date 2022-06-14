//
//  AFApiClient.swift
//  homepoint
//
//  Created by Sendo Tjiam on 25/05/22.
//

import Foundation
import Alamofire

protocol ApiClient {
    func request(
        _ path: String,
        _ method : HTTPMethod,
        _ parameters: Parameters?,
        _ headers: HTTPHeaders?,
        completion: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> Void
    )
}

final class AFApiClient : ApiClient {
    
    private init() {}
    
    static let shared = AFApiClient()
    
    func request(
        _ path: String,
        _ method : HTTPMethod,
        _ parameters: Parameters?,
        _ headers: HTTPHeaders? = nil,
        completion: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> Void
    ) {
        guard let url = URL(string: "\(Constants.BaseUrl)\(path)") else { return }
        AF.request(
            url,
            method: method,
            parameters: parameters ?? nil,
            encoding: JSONEncoding.default,
            headers: headers,
            interceptor: nil,
            requestModifier: nil
        ).response { response in
            let httpResponse = response.response
            completion(httpResponse, response.data, response.error)
        }
    }
}
