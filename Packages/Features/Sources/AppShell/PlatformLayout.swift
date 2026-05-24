import SwiftUI
import StudyFeature
import MasteredListFeature
import StatsFeature
import DesignSystem

@MainActor
public struct PlatformLayout: View {
    let studyVM:    StudySessionViewModel
    let masteredVM: MasteredListViewModel
    let statsVM:    StatsViewModel

    @Environment(AppRouter.self) private var router
    @Environment(\.appTheme) private var theme

    public init(studyVM: StudySessionViewModel,
                masteredVM: MasteredListViewModel,
                statsVM: StatsViewModel) {
        self.studyVM = studyVM
        self.masteredVM = masteredVM
        self.statsVM = statsVM
    }

    public var body: some View {
        @Bindable var router = router
        #if os(macOS)
        macOSLayout(router: $router.selectedTab)
        #else
        iOSLayout(router: $router.selectedTab)
        #endif
    }

    private func iOSLayout(router: Binding<AppTab>) -> some View {
        TabView(selection: router) {
            StudySessionView(vm: studyVM)
                .tabItem { Label("練習", systemImage: "rectangle.on.rectangle") }
                .tag(AppTab.study)
            NavigationStack { MasteredListView(vm: masteredVM) }
                .tabItem { Label("習得済み", systemImage: "checkmark.circle") }
                .tag(AppTab.mastered)
            NavigationStack { StatsView(vm: statsVM) }
                .tabItem { Label("統計", systemImage: "chart.bar") }
                .tag(AppTab.stats)
        }
        .tint(Color.appAccent)
    }

#if os(macOS)
    private func macOSLayout(router: Binding<AppTab>) -> some View {
        NavigationSplitView {
            List {
                sidebarRow(tab: .study,    label: "練習",    icon: "rectangle.on.rectangle", router: router)
                sidebarRow(tab: .mastered, label: "習得済み", icon: "checkmark.circle",       router: router)
                sidebarRow(tab: .stats,    label: "統計",    icon: "chart.bar",               router: router)
            }
            .listStyle(.sidebar)
            .frame(minWidth: 160)
        } detail: {
            switch router.wrappedValue {
            case .study:    StudySessionView(vm: studyVM)
            case .mastered: MasteredListView(vm: masteredVM)
            case .stats:    StatsView(vm: statsVM)
            }
        }
    }

    private func sidebarRow(tab: AppTab, label: String, icon: String, router: Binding<AppTab>) -> some View {
        let selected = router.wrappedValue == tab
        return HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(selected ? theme.accent : theme.textDim)
            Text(label)
                .foregroundStyle(selected ? theme.accent : theme.text)
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(selected ? theme.accent.opacity(0.15) : Color.clear)
        )
        .contentShape(Rectangle())
        .onTapGesture { router.wrappedValue = tab }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
#endif
}
