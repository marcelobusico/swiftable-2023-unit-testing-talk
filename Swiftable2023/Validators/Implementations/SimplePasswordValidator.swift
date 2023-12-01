import Foundation

final class SimplePasswordValidator: PasswordValidator {

    // MARK: Methods

    func validatePasswordAsync(
        _ password: String,
        onSuccess: @escaping (String) -> Void,
        onError: @escaping (String) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.validatePassword(password)
            switch result {
            case .validPassword:
                onSuccess("Your new password looks great!")
            case .invalidPassword:
                onError(InvalidPasswordReason.minimumRequiredLengthNotMet.rawValue)
            }
        }
    }

    func validatePassword(_ password: String) -> ValidationResult {
        if password.count < 8 {
            return .invalidPassword([.minimumRequiredLengthNotMet])
        } else {
            return .validPassword
        }
    }
}
