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

    // MARK: - Discount
    internal func test_PositiveCase_FetchDiscountProducts() {
        /// Given
        let expectedModel = MockProductsData.generateProducts()
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
        let mock = MockApiClient()
//        mock.data = "".data(using: .utf8)
        mock.error = NetworkError.EmptyDataError
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
    
    // MARK: - Latest
    internal func test_PositiveCase_FetchLatestProducts() {
        /// Given
        let expectedModel = MockProductsData.generateProducts()
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
        let mock = MockApiClient()
//        mock.data = "".data(using: .utf8)
        mock.error = NetworkError.EmptyDataError
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

    // MARK: - Get By Id
    internal func test_PositiveCase_GetProductById() {
        /// Given
        var expectedDataModel = MockProductsData.generateProductsDataModel()
        expectedDataModel[0].productImages = MockProductsData.generateProductImagesModel()
        expectedDataModel[0].productCategories = MockProductsData.generateProductCategoriesModel()
        let id = "bd694e4d-fefb-404f-905d-c91aef19595a"
        let mock = MockApiClient()
        mock.data = MockProductsData.generateProductsData()
        sut = ProductsRepository(mock)

        /// When
        let expected = expectation(description: "Should return product - get by id")
        sut.getProduct(by: id) { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response.data, expectedDataModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_GetProductById_ApiError() {
        /// Given
        let id = "bd694e4d-fefb-404f-905d-c91aef19595a"
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.getProduct(by: id) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_GetProductById_EmptyDataError() {
        /// Given
        let id = "bd694e4d-fefb-404f-905d-c91aef19595a"
        let mock = MockApiClient()
        mock.error = NetworkError.EmptyDataError
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.getProduct(by: id) { response, error in
            guard let error = error else { return }
            /// Then
            print(error, "ERROR")
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    // MARK: - Search By Name
    internal func test_PositiveCase_SearchProductByName() {
        /// Given
        let name = "abc"
        let expectedDataModel = MockProductsData.generateProducts()
        let mock = MockApiClient()
        mock.data = MockProductsData.generateProductsData()
        sut = ProductsRepository(mock)

        /// When
        let expected = expectation(description: "Should return product - get by id")
        sut.fetchProducts(by: name) { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedDataModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_SearchProductByName_ApiError() {
        /// Given
        let name = "abc"
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.fetchProducts(by: name) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    internal func test_NegativeCase_SearchProductByName_EmptyDataError() {
        /// Given
        let name = "abc"
        let mock = MockApiClient()
        mock.error = NetworkError.EmptyDataError
        sut = ProductsRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.fetchProducts(by: name) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
}
