import RxSwift
import SwiftUI

struct ResetPasswordView: View {

    @State private var password: String = ""
    @State private var validationMessage: String = "a"
    @State private var validationMessageColor: Color = .black

    private let viewModel: ResetPasswordViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: ResetPasswordViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            SecureField("Enter your new password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text(validationMessage)
                .foregroundColor(validationMessageColor)
                .padding()
        }
        .onChange(of: password, { _, newValue in viewModel.passwordRelay.accept(newValue) })
        .onAppear(perform: { setUpBindings() })
        .padding()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        disposeBag.insert([
            viewModel.validationMessage.drive(onNext: { validationMessage = $0 }),
            viewModel.validationMessageColor.drive(onNext: { validationMessageColor = $0 }),
        ])
    }
}

#Preview {
    ResetPasswordView(
        viewModel: ResetPasswordViewModel(
            passwordValidator: SimplePasswordValidator()
        )
    )
}
