import Foundation

class LegacyPasswordValidator {

    func isPasswordValid(_ password: String) -> Bool {
        if password.count < 8 {
            return false
        }
        if !password.contains(/[a-z]/) {
            return false
        }
        if !password.contains(/[A-Z]/) {
            return false
        }
        if !password.contains(/\d/) {
            return false
        }
        if !password.contains(/[\.!\-_]/) {
            return false
        }
        return true
    }
}
