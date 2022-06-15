//
//  UserRepository.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 14/06/22.
//

import XCTest
@testable import homepoint

final class UserRepositoryTest: XCTestCase {

    var sut : UserRepository!
    
    internal func test_PositiveCase_Login() {
        /// Given
        let params : [String : Any] = LoginRequestModel(
            email: "sendo@mail.com",
            password: "12345"
        ).toDictionary()
        var expectedModel = MockUserData.generateLoginResponseModel()
        expectedModel.data = MockUserData.generateLoginDataModel()
        let mock = MockApiClient()
        mock.data = MockUserData.generateLoginData()
        sut = UserRepository(mock)

        /// When
        let expected = expectation(description: "Should have return token")
        sut.login(params: params) { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_Login() {
        /// Given
        let params : [String : Any] = LoginRequestModel(
            email: "sendo@mail.com",
            password: "12345"
        ).toDictionary()
        let expectedError = NetworkError.ApiError
        let mock = MockApiClient()
        mock.error = AuthError.FailedLogin
        sut = UserRepository(mock)
        
        /// When
        let expectation = expectation(description: "Should have return failed login")
        sut.login(params: params) { response, error in
            /// Then
            guard let error = error else { return }
            XCTAssertEqual(error as! NetworkError, expectedError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    internal func test_PositiveCase_Register() {
        /// Given
        let params : [String : Any] = RegisterRequestModel(
            email: "sendo@mail.com",
            name: "sendo",
            password: "12345"
        ).toDictionary()
        var expectedModel = MockUserData.generateRegisterResponseModel()
        expectedModel.data = MockUserData.generateRegisterDataModel()
        let mock = MockApiClient()
        mock.data = MockUserData.generateRegisterData()
        let sut = UserRepository(mock)

        /// When
        let expected = expectation(description: "Should have return success register")
        sut.register(params: params) { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }

    internal func test_NegativeCase_Register() {
        /// Given
        let params : [String : Any] = RegisterRequestModel(
            email: "sendo@mail.com",
            name: "sendo",
            password: "12345"
        ).toDictionary()
        let expectedError = NetworkError.ApiError
        let mock = MockApiClient()
        mock.error = AuthError.FailedRegister
        sut = UserRepository(mock)

        /// When
        let expectation = expectation(description: "Should have return failed register")
        sut.register(params: params) { response, error in
            /// Then
            guard let error = error else { return }
            XCTAssertEqual(error as! NetworkError, expectedError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
