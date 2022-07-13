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
    
    func request(
        _ path: String,
        _ method : HTTPMethod,
        _ parameters: Parameters?,
        _ headers: HTTPHeaders?,
        completion: @escaping (_ response: URLResponse?, _ data: Data?, _ error: Error?) -> Void
    ) {
        guard let url = URL(string: "\(Constants.BaseUrl)\(path)")
        else { return }
        var encoder : ParameterEncoding = JSONEncoding.default
        if let headers = headers {
            if headers["Content-Type"] == "application/x-www-form-urlencoded" {
                encoder = URLEncoding.default
            }
        }
        AF.request(
            url,
            method: method,
            parameters: parameters ?? nil,
            encoding: encoder,
            headers: headers,
            interceptor: nil,
            requestModifier: nil
        ).response { response in
            let httpResponse = response.response
            completion(httpResponse, response.data, response.error)
        }
    }
}
