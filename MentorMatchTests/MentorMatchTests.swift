//
//  MentorMatchTests.swift
//  MentorMatchTests
//
//  Created by Тася Галкина on 07.03.2024.
//

import XCTest
@testable import MentorMatch

final class MentorMatchTests: XCTestCase {
    
    var authManager: AuthFirebase!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
                authManager = AuthFirebase()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        authManager = nil
                super.tearDown()
    }
    
       func testSuccessfulSignIn() {
           let expectation = XCTestExpectation(description: "Successful sign in")
           authManager.signIn(email: "meow@meow.ru", password: "meowW123") { result in
               switch result {
               case .success(let success):
                   XCTAssertTrue(success, "Sign in should be successful")
               case .failure(let error):
                   XCTFail("Unexpected error: \(error)")
               }
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 5.0)
       }

       func testUnsuccessfulSignIn() {
           let expectation = XCTestExpectation(description: "Unsuccessful sign in")
           authManager.signIn(email: "invalid@example.com", password: "invalidpassword") { result in
               switch result {
               case .success:
                   XCTFail("Sign in should be unsuccessful")
               case .failure(let error):
                   XCTAssertEqual(error, .error("The supplied auth credential is malformed or has expired."), "неверно введенные данные")
               }
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 5.0)
       }

}
