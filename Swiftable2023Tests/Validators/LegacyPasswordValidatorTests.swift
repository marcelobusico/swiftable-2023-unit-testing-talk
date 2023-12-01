import Foundation
import XCTest
@testable import Swiftable2023

class LegacyPasswordValidatorTests: XCTestCase {

    var passwordValidator: LegacyPasswordValidator!

    override func setUp() {
        super.setUp()
        passwordValidator = LegacyPasswordValidator()
    }

    func test_isPasswordValid_withEmptyPassword_shouldReturnFalse() {
        // Setup
        let password = ""
        // Test
        let isPasswordValid = passwordValidator.isPasswordValid(password)
        // Verify
        XCTAssertFalse(isPasswordValid, "Empty password shouldn't be valid.")
    }

    func test_isPasswordValid_withLessThan8Characters_shouldReturnFalse() {
        // Setup
        let password = "Mnb.23"
        // Test
        let isPasswordValid = passwordValidator.isPasswordValid(password)
        // Verify
        XCTAssertFalse(isPasswordValid, "Short password shouldn't be valid.")
    }

    func test_isPasswordValid_withoutAnyNumber_shouldReturnFalse() {
        // Setup
        let password = "Marce.Busico"
        // Test
        let isPasswordValid = passwordValidator.isPasswordValid(password)
        // Verify
        XCTAssertFalse(isPasswordValid, "Password without any number shouldn't be valid.")
    }

    func test_isPasswordValid_withoutAnyLowercaseLetter_shouldReturnFalse() {
        // Setup
        let password = "MARCE.2023"
        // Test
        let isPasswordValid = passwordValidator.isPasswordValid(password)
        // Verify
        XCTAssertFalse(isPasswordValid, "Password without any lowercase letter shouldn't be valid.")
    }

    func test_isPasswordValid_withoutAnyUppercaseLetter_shouldReturnFalse() {
        // Setup
        let password = "marce.2023"
        // Test
        let isPasswordValid = passwordValidator.isPasswordValid(password)
        // Verify
        XCTAssertFalse(isPasswordValid, "Password without any uppercase letter shouldn't be valid.")
    }

    func test_isPasswordValid_withoutAnySpecialCharacter_shouldReturnFalse() {
        // Setup
        let password = "Marce2023"
        // Test
        let isPasswordValid = passwordValidator.isPasswordValid(password)
        // Verify
        XCTAssertFalse(isPasswordValid, "Password without any special character shouldn't be valid.")
    }

    func test_isPasswordValid_withAllRequiredCharactersAndLength_shouldReturnTrue() {
        // Setup
        let password = "Marce.2023"
        // Test
        let isPasswordValid = passwordValidator.isPasswordValid(password)
        // Verify
        XCTAssertTrue(isPasswordValid, "Password matching all requirements should be valid.")
    }
}




