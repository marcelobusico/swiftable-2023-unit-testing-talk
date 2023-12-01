import Foundation
import XCTest
@testable import Swiftable2023

class SimplePasswordValidatorTests: XCTestCase {

    // MARK: Private Properties

    private let testTimeout: TimeInterval = 5
    private var passwordValidator: SimplePasswordValidator!

    // MARK: Set Up

    override func setUp() {
        super.setUp()
        passwordValidator = SimplePasswordValidator()
    }

    // MARK: Validate Password Tests

    func test_validatePassword_withLessThan8Characters_shouldReturnInvalidPasswordWithMinimumRequiredLengthNotMet() {
        // Setup
        let password = "marce"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .invalidPassword([.minimumRequiredLengthNotMet]), "Short password shouldn't be valid.")
    }

    func test_validatePassword_withMoreThan8Characters_shouldReturnValidPassword() {
        // Setup
        let password = "marcelobusico"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .validPassword, "Password matching all requirements should be valid.")
    }

    // MARK: Validate Password Async Tests

    func test_validatePasswordAsync_withMoreThan8Characters_shouldCallOnSuccess() {
        // Setup
        let password = "MarceloBusico"
        let expectation = expectation(description: "password validation completed")

        // Test
        passwordValidator.validatePasswordAsync(
            password,
            onSuccess: { message in
                defer { expectation.fulfill() }
                XCTAssertEqual(message, "Your new password looks great!")
            },
            onError: { _ in
                defer { expectation.fulfill() }
                XCTFail("The password should be valid")
            }
        )

        // Wait
        wait(for: [expectation], timeout: testTimeout)
    }

    func test_validatePasswordAsync_withLessThan8Characters_shouldCallOnError() {
        // Setup
        let password = "Marcelo"
        let expectation = expectation(description: "password validation completed")

        // Test
        passwordValidator.validatePasswordAsync(
            password,
            onSuccess: { _ in
                defer { expectation.fulfill() }
                XCTFail("The password should be valid")
            },
            onError: { message in
                defer { expectation.fulfill() }
                XCTAssertEqual(message, "You need at least 8 characters")
            }
        )

        // Wait
        wait(for: [expectation], timeout: testTimeout)
    }
}
