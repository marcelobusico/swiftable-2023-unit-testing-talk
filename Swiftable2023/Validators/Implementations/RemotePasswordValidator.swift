import Foundation

final class RemotePasswordValidator: PasswordValidator {

    // MARK: Private Propertis

    private let simulatedValidator: PasswordValidator
    private let simulatedDelay: Double
    private var currentValidationTask: Task<Void, Error>?

    // MARK: Initializers

    init(simulatedValidator: PasswordValidator, simulatedDelay: Double = 1) {
        self.simulatedValidator = simulatedValidator
        self.simulatedDelay = simulatedDelay
    }

    // MARK: Methods

    func validatePasswordAsync(
        _ password: String,
        onSuccess: @escaping (String) -> Void,
        onError: @escaping (String) -> Void
    ) {
        currentValidationTask?.cancel()
        currentValidationTask = Task {
            // Simulate a delay
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + simulatedDelay) {
                guard !Task.isCancelled else { return }
                self.simulatedValidator.validatePasswordAsync(
                    password,
                    onSuccess: { message in
                        guard !Task.isCancelled else { return }
                        onSuccess(message)
                    },
                    onError: { message in
                        guard !Task.isCancelled else { return }
                        onError(message)
                    }
                )
            }
        }
    }
}
