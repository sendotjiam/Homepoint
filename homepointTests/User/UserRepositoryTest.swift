//
//  UserRepository.swift
//  homepointTests
//
//  Created by Sendo Tjiam on 14/06/22.
//

import XCTest
@testable import homepoint

final class UserRepositoryTest: XCTestCase {

    internal func test_PositiveCase_Login() {
        // GIVEN
        let sut = MockPositiveUserRepository()
        let params : [String : Any] = LoginRequestModel(
            email: "sendo@mail.com",
            password: "12345"
        ).toDictionary()

        // WHEN
        let expected = expectation(description: "Should have return token")
        sut.login(params: params) { response, error in
            // THEN
            guard let response = response else { return }
            XCTAssertEqual(response, MockUserData.generateLoginData())
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_Login() {
        // GIVEN
        let sut = MockNegativeUserRepository()
        let params : [String : Any] = LoginRequestModel(
            email: "sendo@mail.com",
            password: "12345"
        ).toDictionary()

        // WHEN
        let expectation = expectation(description: "Should have return failed login")
        sut.login(params: params) { response, error in
            // THEN
            guard let error = error else { return }
            XCTAssertEqual(error as! AuthError, AuthError.FailedLogin)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    internal func test_PositiveCase_Register() {
        // GIVEN
        let sut = MockPositiveUserRepository()
        let params : [String : Any] = RegisterRequestModel(
            email: "sendo@mail.com",
            name: "sendo",
            password: "12345"
        ).toDictionary()

        // WHEN
        let expected = expectation(description: "Should have return success register")
        sut.register(params: params) { response, error in
            // THEN
            guard let response = response else { return }
            XCTAssertEqual(response, MockUserData.generateRegisterData())
            expected.fulfill()
        }
        wait(for: [expected], timeout: 1)
    }
    
    internal func test_NegativeCase_Register() {
        // GIVEN
        let sut = MockNegativeUserRepository()
        let params : [String : Any] = RegisterRequestModel(
            email: "sendo@mail.com",
            name: "sendo",
            password: "12345"
        ).toDictionary()

        // WHEN
        let expectation = expectation(description: "Should have return failed register")
        sut.register(params: params) { response, error in
            // THEN
            guard let error = error else { return }
            XCTAssertEqual(error as! AuthError, AuthError.FailedRegister)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
