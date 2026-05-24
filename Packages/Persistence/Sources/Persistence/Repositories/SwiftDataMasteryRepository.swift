import SwiftData
import Foundation
import Core

@MainActor
public final class SwiftDataMasteryRepository: MasteryRepository {
    private let context: ModelContext

    public init(context: ModelContext) { self.context = context }

    public func masteredWordIDs() throws -> Set<UUID> {
        Set(try context.fetch(FetchDescriptor<WordMasteryEntity>()).compactMap { $0.word?.wordID })
    }

    public func masteredWords() throws -> [Word] {
        try context.fetch(FetchDescriptor<WordMasteryEntity>()).compactMap { $0.word?.toDomain() }
    }

    public func masteredCount() throws -> Int {
        try context.fetchCount(FetchDescriptor<WordMasteryEntity>())
    }

    public func markMastered(wordID: UUID) throws {
        // Enforce uniqueness manually (CloudKit doesn't support @Attribute(.unique))
        let existing = try context.fetch(FetchDescriptor<WordMasteryEntity>())
        guard !existing.contains(where: { $0.word?.wordID == wordID }) else { return }
        let words = try context.fetch(FetchDescriptor<WordEntity>())
        guard let entity = words.first(where: { $0.wordID == wordID }) else { return }
        context.insert(WordMasteryEntity(word: entity))
        try context.save()
    }

    public func unmarkMastered(wordID: UUID) throws {
        let masteries = try context.fetch(FetchDescriptor<WordMasteryEntity>())
        masteries.filter { $0.word?.wordID == wordID }.forEach { context.delete($0) }
        try context.save()
    }

    public func resetAll() throws {
        try context.fetch(FetchDescriptor<WordMasteryEntity>()).forEach { context.delete($0) }
        try context.save()
    }
}
