import SwiftUI

@main
struct Swiftable2023App: App {

    let passwordValidator = PasswordValidator()

    var body: some Scene {
        WindowGroup {
            ContentView(passwordValidator: passwordValidator)
        }
    }
}
