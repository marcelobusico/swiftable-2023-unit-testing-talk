import Foundation
import RxCocoa
import RxRelay
import RxSwift
import SwiftUI

final class ResetPasswordViewModel {

    // MARK: Input Observables

    let passwordRelay = ReplayRelay<String>.create(bufferSize: 1)
    private lazy var password = passwordRelay.asDriver(onErrorJustReturn: "")

    // MARK: Output Observables

    private(set) lazy var validationMessage = validationMessageRelay
        .subscribe(on: MainScheduler.instance)
        .asDriver(onErrorJustReturn: "")
    private let validationMessageRelay = BehaviorRelay<String>(
        value: "Please enter your new password"
    )

    private(set) lazy var validationMessageColor = validationMessageColorRelay
        .subscribe(on: MainScheduler.instance)
        .asDriver(onErrorJustReturn: .black)
    private let validationMessageColorRelay = BehaviorRelay<Color>(value: .black)

    // MARK: Private Properties

    private let disposeBag = DisposeBag()
    private let passwordValidator: PasswordValidator

    // MARK: Initializers

    init(passwordValidator: PasswordValidator) {
        self.passwordValidator = passwordValidator
        setUpBindings()
    }

    // MARK: Private Methods

    func setUpBindings() {
        password.drive(
            with: self,
            onNext: { owner, password in
                owner.validationMessageRelay.accept("Validating password...")
                owner.validationMessageColorRelay.accept(.black)

                owner.passwordValidator.validatePasswordAsync(
                    password,
                    onSuccess: { message in
                        owner.validationMessageRelay.accept(message)
                        owner.validationMessageColorRelay.accept(.green)
                    },
                    onError: { message in
                        owner.validationMessageRelay.accept(message)
                        owner.validationMessageColorRelay.accept(.red)
                    }
                )
            }
        ).disposed(by: disposeBag)
    }
}
