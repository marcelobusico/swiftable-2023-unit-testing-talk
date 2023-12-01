import Foundation

class PasswordValidator {

    enum InvalidPasswordReason: String, Equatable {
        case minimumRequiredLengthNotMet = "You need at least 8 characters"
        case missingAnyLowercaseLetter = "You need at least one lowercase letter"
        case missingAnyUppercaseLetter = "You need at least one uppercase letter"
        case missingAnyNumber = "You need at least one number"
        case missingAnySpecialCharacters = "You need at least one special character (!.-_)"
    }

    enum ValidationResult: Equatable {
        case validPassword
        case invalidPassword([InvalidPasswordReason])
    }

    func validatePassword(_ password: String) -> ValidationResult {
        var invalidReasons = [InvalidPasswordReason]()
        if password.count < 8 { invalidReasons.append(.minimumRequiredLengthNotMet) }
        if !password.contains(/[a-z]/) { invalidReasons.append(.missingAnyLowercaseLetter) }
        if !password.contains(/[A-Z]/) { invalidReasons.append(.missingAnyUppercaseLetter) }
        if !password.contains(/\d/) { invalidReasons.append(.missingAnyNumber) }
        if !password.contains(/[\.!\-_]/) { invalidReasons.append(.missingAnySpecialCharacters) }
        if invalidReasons.isEmpty { return .validPassword } else { return .invalidPassword(invalidReasons) }
    }

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
            case let .invalidPassword(reasons):
                var message = ""
                reasons.forEach { message += $0.rawValue + "\n" }
                onError(message)
            }
        }
    }
}
