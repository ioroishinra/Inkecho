import SwiftUI
import SwiftData
import Persistence
import AppShell
import StudyFeature

@main
struct WagoRenshuchouApp: App {
    let container: ModelContainer = {
        guard let c = try? ModelContainer.appContainer() else {
            fatalError("Failed to create ModelContainer")
        }
        return c
    }()

    @State private var studyVM: StudySessionViewModel?

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .modelContainer(container)
                .preferredColorScheme(.dark)
                .frame(minWidth: 900, minHeight: 600)
        }
        .commands {
            CommandGroup(replacing: .newItem) {}
            CommandMenu("表示") {
                Button("練習") {}    .keyboardShortcut("1", modifiers: .command)
                Button("習得済み") {}.keyboardShortcut("2", modifiers: .command)
                Button("統計") {}   .keyboardShortcut("3", modifiers: .command)
            }
        }
    }
}
