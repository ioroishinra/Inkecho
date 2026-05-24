import SwiftUI
import SwiftData
import Core
import Persistence
import StudyFeature
import MasteredListFeature
import StatsFeature
import DesignSystem

@MainActor
public struct AppRootView: View {
    @Environment(\.modelContext) private var ctx
    @AppStorage("appTheme") private var themeName: String = AppTheme.darkInk.rawValue
    private var theme: AppTheme { AppTheme(rawValue: themeName) ?? .darkInk }

    private var wordRepo:    any WordRepository    { SwiftDataWordRepository(context: ctx) }
    private var masteryRepo: any MasteryRepository { SwiftDataMasteryRepository(context: ctx) }
    private var studyRepo:   any StudyRecordRepository { SwiftDataStudyRecordRepository(context: ctx) }

    @State private var studyVM:    StudySessionViewModel?
    @State private var masteredVM: MasteredListViewModel?
    @State private var statsVM:    StatsViewModel?

    public init() {}

    public var body: some View {
        Group {
            if let svm = studyVM, let mvm = masteredVM, let stvm = statsVM {
                PlatformLayout(studyVM: svm, masteredVM: mvm, statsVM: stvm)
            } else {
                theme.bg.ignoresSafeArea()
            }
        }
        .environment(\.appTheme, theme)
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
        .onAppear { bootstrap() }
    }

    private func bootstrap() {
        let wr = wordRepo; let mr = masteryRepo; let sr = studyRepo
        try? DatabaseSeeder(context: ctx).seedIfNeeded()
        studyVM    = StudySessionViewModel(wordRepo: wr, masteryRepo: mr, studyRepo: sr)
        masteredVM = MasteredListViewModel(masteryRepo: mr)
        statsVM    = StatsViewModel(wordRepo: wr, masteryRepo: mr, studyRepo: sr)
    }
}
