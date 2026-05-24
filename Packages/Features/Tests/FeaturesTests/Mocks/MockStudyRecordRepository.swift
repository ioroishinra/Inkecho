import Foundation
import Core

@MainActor
final class MockStudyRecordRepository: StudyRecordRepository {
    var recordedResults: [(UUID, StudyResult)] = []
    var shouldThrow = false

    func record(wordID: UUID, result: StudyResult) throws {
        if shouldThrow { throw MockError.intentional }
        recordedResults.append((wordID, result))
    }

    func totalStudiedCount() throws -> Int {
        if shouldThrow { throw MockError.intentional }
        return recordedResults.count
    }
}
