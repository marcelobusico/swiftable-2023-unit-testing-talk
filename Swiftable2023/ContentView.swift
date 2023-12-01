import SwiftUI

struct ContentView: View {
    @State private var password: String = ""
    @State private var validationMessage: String = ""
    @State private var validationMessageColor: Color = .green
    private let passwordValidator: PasswordValidator

    init(passwordValidator: PasswordValidator) {
        self.passwordValidator = passwordValidator
    }

    var body: some View {
        VStack {
            SecureField("Enter your new password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Text(validationMessage)
                .foregroundColor(validationMessageColor)
                .padding()

        }
        .onChange(of: password, { _, newValue in
            let result = passwordValidator.validatePassword(newValue)

            switch result {
            case .validPassword:
                validationMessage = "Your new password looks great!"
                validationMessageColor = .green
            case let .invalidPassword(reasons):
                validationMessage = ""
                reasons.forEach { validationMessage += $0.rawValue + "\n" }
                validationMessageColor = .red
            }
        })
        .padding()
    }
}

#Preview {
    ContentView(passwordValidator: PasswordValidator())
}
