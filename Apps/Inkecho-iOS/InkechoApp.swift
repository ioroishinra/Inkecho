import SwiftUI
import SwiftData
import Persistence
import AppShell

@main
struct InkechoApp: App {
    let container: ModelContainer = {
        guard let c = try? ModelContainer.appContainer() else {
            fatalError("Failed to create ModelContainer")
        }
        return c
    }()

    @State private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .modelContainer(container)
                .environment(router)
        }
    }
}
