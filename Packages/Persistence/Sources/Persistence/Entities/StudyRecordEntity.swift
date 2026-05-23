import SwiftData
import Foundation

@Model
final class StudyRecordEntity {
    var recordID: UUID
    var result: String
    var studiedAt: Date
    var word: WordEntity?

    init(word: WordEntity, result: StudyResult) {
        self.recordID = UUID()
        self.word = word
        self.result = result.rawValue
        self.studiedAt = .now
    }
}
