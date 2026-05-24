import SwiftData
import Foundation
import Core

@MainActor
public final class SwiftDataStudyRecordRepository: StudyRecordRepository {
    private let context: ModelContext

    public init(context: ModelContext) { self.context = context }

    public func record(wordID: UUID, result: StudyResult) throws {
        let words = try context.fetch(FetchDescriptor<WordEntity>())
        guard let entity = words.first(where: { $0.wordID == wordID }) else { return }
        context.insert(StudyRecordEntity(word: entity, result: result))
        try context.save()
    }

    public func totalStudiedCount() throws -> Int {
        try context.fetchCount(FetchDescriptor<StudyRecordEntity>())
    }
}
