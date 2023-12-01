import Foundation
import XCTest
@testable import Swiftable2023

class RemotePasswordValidatorTests: XCTestCase {

    // MARK: Private Properties

    private let testTimeout: TimeInterval = 5
    private var simulatedValidator: StubPasswordValidator!
    private var passwordValidator: RemotePasswordValidator!

    // MARK: Set Up

    override func setUp() {
        super.setUp()
        simulatedValidator = StubPasswordValidator()
        passwordValidator = RemotePasswordValidator(
            simulatedValidator: simulatedValidator,
            simulatedDelay: 0
        )
    }

    // MARK: Validate Password Async Tests

    func test_validatePasswordAsync_withSimulatedSuccess_shouldCallOnSuccess() {
        // Setup
        simulatedValidator.shouldSucceed = true
        simulatedValidator.resultMessage = "Success!"
        let password = "Mnb.23"
        let expectation = expectation(description: "password validation completed")

        // Test
        passwordValidator.validatePasswordAsync(
            password,
            onSuccess: { message in
                defer { expectation.fulfill() }
                XCTAssertEqual(message, "Success!")
            },
            onError: { message in
                defer { expectation.fulfill() }
                XCTFail("The password should be valid")
            }
        )

        // Wait
        wait(for: [expectation], timeout: testTimeout)
    }

    func test_validatePasswordAsync_withSimulatedError_shouldCallOnError() {
        // Setup
        simulatedValidator.shouldSucceed = false
        simulatedValidator.resultMessage = "Error!"
        let password = "Mnb.23"
        let expectation = expectation(description: "password validation completed")

        // Test
        passwordValidator.validatePasswordAsync(
            password,
            onSuccess: { message in
                defer { expectation.fulfill() }
                XCTFail("The password should be valid")
            },
            onError: { message in
                defer { expectation.fulfill() }
                XCTAssertEqual(message, "Error!")
            }
        )

        // Wait
        wait(for: [expectation], timeout: testTimeout)
    }
}
