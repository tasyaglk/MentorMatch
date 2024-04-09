////
////  MentorMatchOrderTests.swift
////  MentorMatchOrderTests
////
////  Created by Тася Галкина on 07.03.2024.
////
//
//import XCTest
//import Firebase
//@testable import MentorMatch
//
//final class MentorMatchOrderTests: XCTestCase {
//    
//    var authFirebase: AuthFirebase!
//        var email: String!
//        var order: Order!
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        super.setUp()
//        super.setUp()
//                authFirebase = AuthFirebase()
//                email = "test@example.com"
//                order = Order(isActive: true, selectedSkills: ["Skill1", "Skill2"], comment: "Test comment", byUserEmail: email)
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        authFirebase = nil
//                email = nil
//                order = nil
//                super.tearDown()
//    }
//    
//    func testSaveOrder() throws {
//            // Arrange
//            let db = Firestore.firestore()
//            let collection = db.collection("users").document(email).collection("orders")
//        let document = collection.document(order.id ?? "")
//
//            // Act
//            authFirebase.saveOrder(email: email, order: order)
//
//            // Assert
//            let expectation = XCTestExpectation(description: "Order saved successfully")
//            document.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    expectation.fulfill()
//                } else {
//                    XCTFail("Order was not saved")
//                }
//            }
//            wait(for: [expectation], timeout: 5.0)
//        }
//
//}
