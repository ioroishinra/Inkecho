import SwiftData

@MainActor
public final class SwiftDataWordRepository: WordRepository {
    private let context: ModelContext

    public init(context: ModelContext) { self.context = context }

    public func fetchAll() throws -> [Word] {
        let desc = FetchDescriptor<WordEntity>(sortBy: [SortDescriptor(\.kanji)])
        return try context.fetch(desc).map { $0.toDomain() }
    }

    public func count() throws -> Int {
        try context.fetchCount(FetchDescriptor<WordEntity>())
    }
}
