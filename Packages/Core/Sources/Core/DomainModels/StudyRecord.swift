import Foundation

public struct StudyRecord: Identifiable, Sendable {
    public let id: UUID
    public let wordID: UUID
    public let result: StudyResult
    public let studiedAt: Date

    public init(id: UUID = UUID(), wordID: UUID, result: StudyResult, studiedAt: Date = .now) {
        self.id = id; self.wordID = wordID
        self.result = result; self.studiedAt = studiedAt
    }
}
