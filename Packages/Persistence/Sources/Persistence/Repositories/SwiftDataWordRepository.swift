import SwiftData
import Foundation
import Core

@MainActor
public final class SwiftDataWordRepository: WordRepository {
    private let context: ModelContext

    public init(context: ModelContext) { self.context = context }

    public func fetchAll() throws -> [Word] {
        let descriptor = FetchDescriptor<WordEntity>(
            sortBy: [SortDescriptor(\WordEntity.kanji)]
        )
        return try context.fetch(descriptor).map { $0.toDomain() }
    }

    public func count() throws -> Int {
        try context.fetchCount(FetchDescriptor<WordEntity>())
    }
}
