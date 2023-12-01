import Foundation
@testable import Swiftable2023

class StubPasswordValidator: PasswordValidator {
    var shouldSucceed = false
    var resultMessage = "Stub!"

    func validatePasswordAsync(
        _ password: String,
        onSuccess: @escaping (String) -> Void,
        onError: @escaping (String) -> Void
    ) {
        if shouldSucceed {
            onSuccess(resultMessage)
        } else {
            onError(resultMessage)
        }
    }
}
