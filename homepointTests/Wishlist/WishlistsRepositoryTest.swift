//
//  WishlistsRepositoryTest.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 09/07/22.
//

import XCTest
@testable import homepoint

final class WishlistsRepository: XCTestCase {
    
    var sut : WishlistRepository!

    // MARK: - Add Wishlist
    internal func test_PositiveCase_AddWishlist() {
        /// Given
        let expectedModel = MockWishlistsData.generateWishlists()
        let mock = MockApiClient()
        mock.data = MockWishlistsData.generateWishlistsData()
        sut = WishlistRepository(mock)
        let params = [
            "userId" : "",
            "productId": ""
        ]
        /// When
        let expected = expectation(description: "Should return wishlists")
        sut.addWishlist(params: params) { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }

    internal func test_NegativeCase_AddWishlist_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = WishlistRepository(mock)
        let params = [
            "userId" : "",
            "productId": ""
        ]
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.addWishlist(params: params) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_AddWishlist_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = WishlistRepository(mock)
        let params = [
            "userId" : "",
            "productId": ""
        ]
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.addWishlist(params: params) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    // MARK: - Delete Wishlists
    internal func test_PositiveCase_DeleteWishlist() {
        /// Given
        let expectedModel = MockWishlistsData.generateWishlists()
        let mock = MockApiClient()
        mock.data = MockWishlistsData.generateWishlistsData()
        sut = WishlistRepository(mock)

        /// When
        let expected = expectation(description: "Should return wishlists")
        sut.deleteWishlist(id: "") { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }

    internal func test_NegativeCase_DeleteWishlist_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = WishlistRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.deleteWishlist(id: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_DeleteWishlist_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = WishlistRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.deleteWishlist(id: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    // MARK: - Fetch Wishlists
    internal func test_PositiveCase_FetchWishlists() {
        /// Given
        let expectedModel = MockWishlistsData.generateAllWishlists()
        let mock = MockApiClient()
        mock.data = MockWishlistsData.generateAllWishlistsData()
        sut = WishlistRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return all wishlists")
        sut.fetchWishlists(userId: "") { response, error in
            guard let response = response else { return }
            /// Then
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }

    internal func test_NegativeCase_FetchWishlists_EmptyDataError() {
        /// Given
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = WishlistRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.fetchWishlists(userId: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_FetchWishlists_ApiError() {
        /// Given
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = WishlistRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.fetchWishlists(userId: "") { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
}

//"AllWishlistsResponseModel(success: true, status: "200 OK", message: "Wishlist found successfully", data: homepoint.AllWishlistsDataModel(totalPage: 1, totalRecord: 1, currentPage: 0, pageSize: 1, wishlistItems: []))")
//
//"AllWishlistsResponseModel(success: true, status: "200 OK", message: "Wishlist found successfully", data: homepoint.AllWishlistsDataModel(totalPage: 1, totalRecord: 1, currentPage: 0, pageSize: 1, wishlistItems: [homepoint.WishlistDataModel(id: "94d50c87-6e4a-4a65-b7a8-650e8c11a7ce", createdAt: "2022-07-09T09:26:32.753+00:00", isDeleted: false, products: homepoint.ProductDataModel(id: "", productSubCategories: homepoint.ProductSubCategoryModel(id: "", name: "", icon: "", isDeleted: false), productImages: [], name: "", description: "", brand: "", price: 0.0, discount: 0.0, stock: 0, color: "", ratingAverage: 0, ratingCount: 0, amountSold: 0, createdAt: "", isDeleted: false))]))")
