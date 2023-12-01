import Foundation

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

protocol PasswordValidator {
    func validatePasswordAsync(
        _ password: String,
        onSuccess: @escaping (String) -> Void,
        onError: @escaping (String) -> Void
    )
}
