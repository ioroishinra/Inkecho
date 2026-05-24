import SwiftData
import Core

@MainActor
public final class DatabaseSeeder {
    private let context: ModelContext

    public init(context: ModelContext) { self.context = context }

    public func seedIfNeeded() throws {
        let existing = try context.fetchCount(FetchDescriptor<WordEntity>())
        guard existing == 0 else { return }
        let words = try SeedLoader.loadWords()
        for word in words {
            context.insert(WordEntity(
                wordID: word.id, kanji: word.kanji, reading: word.reading,
                meaning: word.meaning, example: word.example,
                level: word.level, category: word.category
            ))
        }
        try context.save()
    }
}
