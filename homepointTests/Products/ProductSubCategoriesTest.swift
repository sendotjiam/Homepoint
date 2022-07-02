//
//  ProductSubCategoriesTest.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 02/07/22.
//

import XCTest
@testable import homepoint

final class ProductSubCategoriesTest: XCTestCase {
    
    var sut : ProductSubCategoriesRepository!
    
    internal func test_PositiveCase_FetchSubCategories() {
        /// Given
        let expectedModel = MockProductSubCategoriesData.generateProductSubCategories()
        let mock = MockApiClient()
        mock.data = MockProductSubCategoriesData.generateProductSubCategoriesData()
        sut = ProductSubCategoriesRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return subcategories")
        sut.fetchSubCategories { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchSubCategories_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = ProductSubCategoriesRepository(mock)
        
        let expected = expectation(description: "Should return error - Api Error")
        sut.fetchSubCategories { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchSubCategories_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = ProductSubCategoriesRepository(mock)
        
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.fetchSubCategories { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
        
    }
    
}
