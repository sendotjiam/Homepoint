//
//  ProductsRepositoryTest.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 20/06/22.
//

import XCTest
@testable import homepoint

class ProductsRepositoryTest: XCTestCase {

    var sut : ProductsRepository!

    internal func test_PositiveCase_FetchDiscountProducts() {
        /// Given
        var expectedModel = MockProductsData.generateProducts()
        let mock = MockApiClient()
        mock.data = MockProductsData.generateProductsData()
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return products - discounts")
        sut.fetchProducts(type: .discount) { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchDiscountProducts_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.fetchProducts(type: .discount) { response, error in
            /// Then
            guard let error = error else { return }
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchDiscountProducts_EmptyDataError() {
        /// Given
        var expectedModel = MockProductsData.generateProducts()
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.fetchProducts(type: .discount) { response, error in
            /// Then
            guard let error = error else { return }
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_PositiveCase_FetchLatestProducts() {
        /// Given
        var expectedModel = MockProductsData.generateProducts()
        let mock = MockApiClient()
        mock.data = MockProductsData.generateProductsData()
        sut = ProductsRepository(mock)

        /// When
        let expected = expectation(description: "Should return products - latests")
        sut.fetchProducts(type: .latest) { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchLatestProducts_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.fetchProducts(type: .latest) { response, error in
            /// Then
            guard let error = error else { return }
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchLatestProducts_EmptyDataError() {
        /// Given
        var expectedModel = MockProductsData.generateProducts()
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.fetchProducts(type: .latest) { response, error in
            /// Then
            guard let error = error else { return }
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
}
