import SwiftUI
import SwiftData
import Persistence
import AppShell
import DesignSystem

@main
struct WagoRenshuchouApp: App {
    let container: ModelContainer = {
        guard let c = try? ModelContainer.appContainer() else {
            fatalError("Failed to create ModelContainer")
        }
        return c
    }()

    @State private var router = AppRouter()

    init() {
        #if DEBUG
        if NSFont(name: "KleeOne-Regular", size: 12) == nil {
            print("[WagoRenshuchou] WARNING: KleeOne-Regular not found — check Fonts/ in bundle and ATSApplicationFontsPath in Info.plist")
        }
        #endif
    }

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .modelContainer(container)
                .frame(minWidth: 900, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                .environment(router)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentMinSize)
        .commands {
            CommandGroup(replacing: .newItem) {}
            CommandGroup(replacing: .saveItem) {}
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .pasteboard) {}
            CommandGroup(replacing: .help) {}
            CommandGroup(after: .sidebar) {
                Divider()
                Button("練習")    { router.selectedTab = .study }
                    .keyboardShortcut("1", modifiers: .command)
                Button("習得済み") { router.selectedTab = .mastered }
                    .keyboardShortcut("2", modifiers: .command)
                Button("統計")    { router.selectedTab = .stats }
                    .keyboardShortcut("3", modifiers: .command)
            }
        }

        Settings {
            ThemeSettingsView()
        }
    }
}
