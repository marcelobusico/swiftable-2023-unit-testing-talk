import Foundation
import XCTest
import RxBlocking
@testable import Swiftable2023

class ResetPasswordViewModelTests: XCTestCase {

    // MARK: Private Properties

    private let testTimeout: TimeInterval = 5
    private var passwordValidator: StubPasswordValidator!
    private var viewModel: ResetPasswordViewModel!

    // MARK: Set Up

    override func setUp() {
        super.setUp()
        passwordValidator = StubPasswordValidator()
        viewModel = ResetPasswordViewModel(passwordValidator: passwordValidator)
    }

    // MARK: Password Updated Tests

    func test_passwordUpdated_withSuccessResult_shouldTriggerSuccessMessageWithGreenColor() throws {
        // Setup
        passwordValidator.shouldSucceed = true
        passwordValidator.resultMessage = "Success!"

        // Test
        viewModel.passwordRelay.accept("Test")

        // Verify
        XCTAssertEqual(
            try viewModel.validationMessage.toBlocking(timeout: testTimeout).first(),
            "Success!"
        )
        XCTAssertEqual(
            try viewModel.validationMessageColor.toBlocking(timeout: testTimeout).first(),
            .green
        )
    }

    func test_passwordUpdated_withErrorResult_shouldTriggerErrorMessageWithRedColor() throws {
        // Setup
        passwordValidator.shouldSucceed = false
        passwordValidator.resultMessage = "Error!"

        // Test
        viewModel.passwordRelay.accept("Test")

        // Verify
        XCTAssertEqual(
            try viewModel.validationMessage.toBlocking(timeout: testTimeout).first(),
            "Error!"
        )
        XCTAssertEqual(
            try viewModel.validationMessageColor.toBlocking(timeout: testTimeout).first(),
            .red
        )
    }
}
