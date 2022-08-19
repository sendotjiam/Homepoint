//
//  RepositoryManager.swift
//  homepoint
//
//  Created by Sendo Tjiam on 22/07/22.
//

import Foundation
import SwiftyJSON

final class RepositoryManager {
    
    static let shared = RepositoryManager()
    
    private init() {}
    
    func parse(data: Data?) -> (json : JSON?, error: Error?) {
        if let data = data {
            do {
                let json = try JSON(data: data)
                return (json, nil)
            } catch {
                return (nil, NetworkError.EmptyDataError)
            }
        } else {
            return (nil, NetworkError.ApiError)
        }
    }
}
