//
//  CartRepositoryTest.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 09/07/22.
//

import XCTest
import SwiftyJSON
@testable import homepoint

final class CartRepositoryTest : XCTestCase {
    
    var sut : CartRepository!
    
    // MARK: - Add Cart Item
    internal func test_PositiveCase_AddCart() {
        /// Given
        let expectedModel = MockCartData.generateCart()
        let mock = MockApiClient()
        mock.data = MockCartData.generateCartsData()
        sut = CartRepository(mock)
        let params : [String: Any] = [
            "userId" : "",
            "productId": "",
            "quantity": 1
        ]
        
        /// When
        let expected = expectation(description: "Should return cart response")
        sut.addCart(params: params) { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_AddCart_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = CartRepository(mock)
        let params : [String: Any] = [
            "userId" : "",
            "productId": "",
            "quantity": 1
        ]
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.addCart(params: params) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_AddCart_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = CartRepository(mock)
        let params : [String: Any] = [
            "userId" : "",
            "productId": "",
            "quantity": 1
        ]
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.addCart(params: params) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    // MARK: - Fetch Carts
    internal func test_PositiveCase_FetchCarts() {
        /// Given
        let expectedModel = MockCartData.generateCart()
        let mock = MockApiClient()
        mock.data = MockCartData.generateCartsData()
        sut = CartRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return cart response")
        sut.fetchCarts(userId: "") { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchCarts_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = CartRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.fetchCarts(userId: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchCarts_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = CartRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.fetchCarts(userId: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    // MARK: - Update Cart
    internal func test_PositiveCase_UpdateCart() {
        /// Given
        let expectedModel = MockCartData.generateCart()
        let mock = MockApiClient()
        mock.data = MockCartData.generateCartsData()
        sut = CartRepository(mock)
        let params : [String: Any] = [
            "id" : "",
            "quantity": 2
        ]
        
        /// When
        let expected = expectation(description: "Should return cart response")
        sut.updateCart(params: params) { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_UpdateCart_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = CartRepository(mock)
        let params : [String: Any] = [
            "id" : "",
            "quantity": 2
        ]
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.updateCart(params: params) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_UpdateCart_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = CartRepository(mock)
        let params : [String: Any] = [
            "id" : "",
            "quantity": 2
        ]
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.updateCart(params: params) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    // MARK: - Delete Cart
    internal func test_PositiveCase_DeleteCart() {
        /// Given
        let expectedModel = MockCartData.generateCart()
        let mock = MockApiClient()
        mock.data = MockCartData.generateCartsData()
        sut = CartRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return cart response")
        sut.deleteCart(id: "") { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_DeleteCart_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = CartRepository(mock)
    
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.deleteCart(id: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_DeleteCart_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = CartRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.deleteCart(id: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
}
