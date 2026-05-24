import Foundation
import Core

@MainActor
final class MockMasteryRepository: MasteryRepository {
    var masteredIDs: Set<UUID> = []
    var shouldThrow = false

    func masteredWordIDs() throws -> Set<UUID> {
        if shouldThrow { throw MockError.intentional }
        return masteredIDs
    }

    func masteredWords() throws -> [Word] {
        if shouldThrow { throw MockError.intentional }
        return []
    }

    func masteredCount() throws -> Int {
        if shouldThrow { throw MockError.intentional }
        return masteredIDs.count
    }

    func markMastered(wordID: UUID) throws {
        if shouldThrow { throw MockError.intentional }
        masteredIDs.insert(wordID)
    }

    func unmarkMastered(wordID: UUID) throws {
        if shouldThrow { throw MockError.intentional }
        masteredIDs.remove(wordID)
    }

    func resetAll() throws {
        if shouldThrow { throw MockError.intentional }
        masteredIDs.removeAll()
    }
}
