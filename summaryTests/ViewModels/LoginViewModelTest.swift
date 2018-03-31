//
//  LoginViewModelTest.swift
//  summaryTests
//
//  Copyright © 2017年 ArgentVGL. All rights reserved.
//

import Firebase
import XCTest

class LoginViewModelTest: XCTestCase {
    // this mock class is deprecate and this test code is not goods
    class MockLoginViewModel: LoginViewModel {
        public func errorDescription(error: Error?) -> String? {
            guard let error = error else { return nil }
            return error.localizedDescription
        }
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testErrorDescription() {
        let loginVM: MockLoginViewModel = MockLoginViewModel()
        let error: NSError = NSError(domain: AuthErrorDomain,
                                     code: AuthErrorCode.wrongPassword.rawValue,
                                     userInfo: ["message": "test"])

        XCTAssertNil(loginVM.errorDescription(error: nil))
        XCTAssertNotNil(loginVM.errorDescription(error: error))
    }
}
