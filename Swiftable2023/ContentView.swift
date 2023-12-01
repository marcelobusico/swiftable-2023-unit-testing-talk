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
            passwordValidator.validatePasswordAsync(
                newValue,
                onSuccess: { message in
                    validationMessage = message
                    validationMessageColor = .green
                },
                onError: { message in
                    validationMessage = message
                    validationMessageColor = .red
                }
            )
        })
        .padding()
    }
}

#Preview {
    ContentView(passwordValidator: PasswordValidator())
}
