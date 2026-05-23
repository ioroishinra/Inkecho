import SwiftUI
import SwiftData
import Persistence
import AppShell

@main
struct WagoRenshuchouApp: App {
    let container: ModelContainer = {
        guard let c = try? ModelContainer.appContainer() else {
            fatalError("Failed to create ModelContainer")
        }
        return c
    }()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .modelContainer(container)
                .preferredColorScheme(.dark)
        }
    }
}
