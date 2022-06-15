//
//  MockApiClient.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 15/06/22.
//

import Foundation
import Alamofire
@testable import homepoint

final class MockApiClient : ApiClient {
    var data : Data?
    var error : Error?
    
    func request(
        _ path: String,
        _ method: HTTPMethod,
        _ parameters: Parameters?,
        _ headers: HTTPHeaders?,
        completion: @escaping (URLResponse?, Data?, Error?) -> Void
    ) {
        completion(URLResponse(), data, error)
    }
}
