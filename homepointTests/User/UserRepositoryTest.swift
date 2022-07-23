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
    
    // MARK: - Get User By Id
    internal func test_PositiveCase_GetUserById() {
        /// Given
        let expectedDataModel = MockUserData.generateUserDataModel()
        let id = "95bcdbdf-c95d-48bf-80de-557fb9bfc893"
        let mock = MockApiClient()
        mock.data = MockUserData.generateUserData()
        sut = UserRepository(mock)

        /// When
        let expected = expectation(description: "Should return product - get by id")
        sut.getUser(by: id) { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response.data, expectedDataModel)

    internal func test_PositiveCase_Forget() {
        /// Given
        let params : [String : Any] = ForgetRequestModel(
            email: "tommy@mail.com"
        ).toDictionary()
        var expectedModel = MockUserData.generateForgetResponseModel()
        expectedModel.data = MockUserData.generateForgetDataModel()
        let mock = MockApiClient()
        mock.data = MockUserData.generateForgetData()
        let sut = UserRepository(mock)

        /// When
        let expected = expectation(description: "Should have return success forget")
        sut.forget(params: params) { response, error in
            /// Then
            guard let response = response else { return }
            XCTAssertEqual(response, expectedModel)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_GetUserById_ApiError() {
        /// Given
        let id = "a1a22a38-7a2d-4ee8-bd12-20ddd91e3c0c"
        let mock = MockApiClient()
        mock.error = NetworkError.ApiError
        sut = UserRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Api Error")
        sut.getUser(by: id) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.ApiError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_GetUserById_EmptyDataError() {
        /// Given
        let id = "a1a22a38-7a2d-4ee8-bd12-20ddd91e3c0c"
        let mock = MockApiClient()
        mock.data = "".data(using: .utf8)
        sut = UserRepository(mock)
        
        /// When
        let expected = expectation(description: "Should return error - Empty Data Error")
        sut.getUser(by: id) { response, error in
            guard let error = error else { return }
            /// Then
            XCTAssertEqual(error as! NetworkError, NetworkError.EmptyDataError)
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)


    internal func test_NegativeCase_Forget() {
        /// Given
        let params : [String : Any] = ForgetRequestModel(
            email: "tommy@mail.com"
        ).toDictionary()
        let expectedError = NetworkError.ApiError
        let mock = MockApiClient()
        mock.error = AuthError.FailedRegister
        sut = UserRepository(mock)

        /// When
        let expectation = expectation(description: "Should have return failed forget")
        sut.forget(params: params) { response, error in
            /// Then
            guard let error = error else { return }
            XCTAssertEqual(error as! NetworkError, expectedError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
