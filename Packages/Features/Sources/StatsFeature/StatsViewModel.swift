import SwiftUI
import Core

@Observable
@MainActor
public final class StatsViewModel {
    public private(set) var totalCount: Int = 0
    public private(set) var masteredCount: Int = 0
    public private(set) var studiedCount: Int = 0

    public var unmasteredCount: Int { totalCount - masteredCount }
    public var progress: Double { totalCount > 0 ? Double(masteredCount) / Double(totalCount) : 0 }

    private let wordRepo: any WordRepository
    private let masteryRepo: any MasteryRepository
    private let studyRepo: any StudyRecordRepository

    public init(wordRepo: any WordRepository,
                masteryRepo: any MasteryRepository,
                studyRepo: any StudyRecordRepository) {
        self.wordRepo = wordRepo
        self.masteryRepo = masteryRepo
        self.studyRepo = studyRepo
    }

    public func load() {
        totalCount   = (try? wordRepo.count()) ?? 0
        masteredCount = (try? masteryRepo.masteredCount()) ?? 0
        studiedCount  = (try? studyRepo.totalStudiedCount()) ?? 0
    }
}
