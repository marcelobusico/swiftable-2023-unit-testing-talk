import SwiftUI

@main
struct Swiftable2023App: App {

    private let passwordValidator: PasswordValidator

    init() {
        passwordValidator = RemotePasswordValidator(
            simulatedValidator: ComplexPasswordValidator()
        )
    }

    var body: some Scene {
        WindowGroup {
            ResetPasswordView(
                viewModel: ResetPasswordViewModel(
                    passwordValidator: passwordValidator
                )
            )
        }
    }
}
