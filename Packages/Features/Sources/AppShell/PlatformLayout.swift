import SwiftUI
import StudyFeature
import MasteredListFeature
import StatsFeature

@MainActor
public struct PlatformLayout: View {
    let studyVM:    StudySessionViewModel
    let masteredVM: MasteredListViewModel
    let statsVM:    StatsViewModel

    public init(studyVM: StudySessionViewModel,
                masteredVM: MasteredListViewModel,
                statsVM: StatsViewModel) {
        self.studyVM = studyVM
        self.masteredVM = masteredVM
        self.statsVM = statsVM
    }

    public var body: some View {
        #if os(macOS)
        macOSLayout
        #else
        iOSLayout
        #endif
    }

    // iPhone / iPad
    private var iOSLayout: some View {
        TabView {
            StudySessionView(vm: studyVM)
                .tabItem { Label("練習", systemImage: "rectangle.on.rectangle") }
                .tag(0)
            NavigationStack { MasteredListView(vm: masteredVM) }
                .tabItem { Label("習得済み", systemImage: "checkmark.circle") }
                .tag(1)
            NavigationStack { StatsView(vm: statsVM) }
                .tabItem { Label("統計", systemImage: "chart.bar") }
                .tag(2)
        }
        .tint(Color(red: 0.78, green: 0.62, blue: 0.38))
    }

    // macOS
    private var macOSLayout: some View {
        NavigationSplitView {
            List {
                Label("練習",    systemImage: "rectangle.on.rectangle")
                Label("習得済み", systemImage: "checkmark.circle")
                Label("統計",    systemImage: "chart.bar")
            }
            .listStyle(.sidebar)
            .frame(minWidth: 160)
        } detail: {
            StudySessionView(vm: studyVM)
        }
    }
}
