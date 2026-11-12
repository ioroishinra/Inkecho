import SwiftUI
import Core
import OSLog

private let logger = Logger(subsystem: "Inkecho", category: "StatsViewModel")

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
        do {
            totalCount = try wordRepo.count()
        } catch {
            logger.error("wordRepo.count failed: \(error, privacy: .public)")
            totalCount = 0
        }
        do {
            masteredCount = try masteryRepo.masteredCount()
        } catch {
            logger.error("masteryRepo.masteredCount failed: \(error, privacy: .public)")
            masteredCount = 0
        }
        do {
            studiedCount = try studyRepo.totalStudiedCount()
        } catch {
            logger.error("studyRepo.totalStudiedCount failed: \(error, privacy: .public)")
            studiedCount = 0
        }
    }
}
