import Foundation
import XCTest
@testable import Swiftable2023

class PasswordValidatorTests: XCTestCase {

    // MARK: Private Properties

    private var passwordValidator: PasswordValidator!

    // MARK: Set Up

    override func setUp() {
        super.setUp()
        passwordValidator = PasswordValidator()
    }

    // MARK: Validate Password Tests

    func test_validatePassword_withLessThan8Characters_shouldReturnInvalidPasswordWithMinimumRequiredLengthNotMet() {
        // Setup
        let password = "Mnb.23"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .invalidPassword([.minimumRequiredLengthNotMet]), "Short password shouldn't be valid.")
    }

    func test_validatePassword_withoutAnyNumber_shouldReturnInvalidPasswordWithMissingAnyNumber() {
        // Setup
        let password = "Marce-Busico"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .invalidPassword([.missingAnyNumber]), "Password without any number shouldn't be valid.")
    }

    func test_validatePassword_withoutAnyLowercaseLetter_shouldReturnInvalidPasswordWithMissingAnyLowercaseLetter() {
        // Setup
        let password = "MARCE!2023"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .invalidPassword([.missingAnyLowercaseLetter]), "Password without any lowercase letter shouldn't be valid.")
    }

    func test_validatePassword_withoutAnyUppercaseLetter_shouldReturnInvalidPasswordWithMissingAnyUppercaseLetter() {
        // Setup
        let password = "marce_2023"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .invalidPassword([.missingAnyUppercaseLetter]), "Password without any uppercase letter shouldn't be valid.")
    }

    func test_validatePassword_withoutAnySpecialCharacter_shouldReturnInvalidPasswordWithMissingAnySpecialCharacters() {
        // Setup
        let password = "Marce2023"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .invalidPassword([.missingAnySpecialCharacters]), "Password without any special character shouldn't be valid.")
    }

    func test_validatePassword_withEmptyPassword_shouldReturnInvalidPasswordWithAllReasons() {
        // Setup
        let password = ""
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(
            result,
            .invalidPassword(
                [
                    .minimumRequiredLengthNotMet,
                    .missingAnyLowercaseLetter,
                    .missingAnyUppercaseLetter,
                    .missingAnyNumber,
                    .missingAnySpecialCharacters,
                ]
            ),
            "Empty password shouldn't be valid."
        )
    }

    func test_validatePassword_withAllRequiredCharactersAndLength_shouldReturnValidPassword() {
        // Setup
        let password = "Marce.2023"
        // Test
        let result = passwordValidator.validatePassword(password)
        // Verify
        XCTAssertEqual(result, .validPassword, "Password matching all requirements should be valid.")
    }

    // MARK: Validate Password Async Tests

    func test_validatePasswordAsync_withAllRequiredCharactersAndLength_shouldReturnValidPassword() {
        // Setup
        let password = "Marce.2023"
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
        wait(for: [expectation], timeout: 5)
    }
}
