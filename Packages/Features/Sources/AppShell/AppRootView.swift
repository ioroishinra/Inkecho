import SwiftUI
import SwiftData
import Core
import Persistence
import StudyFeature
import MasteredListFeature
import StatsFeature

@MainActor
public struct AppRootView: View {
    @Environment(\.modelContext) private var ctx

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
                Color(red: 0.059, green: 0.051, blue: 0.043)
                    .ignoresSafeArea()
            }
        }
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
