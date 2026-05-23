import Foundation

@MainActor
public protocol StudyRecordRepository {
    func record(wordID: UUID, result: StudyResult) throws
    func totalStudiedCount() throws -> Int
}
