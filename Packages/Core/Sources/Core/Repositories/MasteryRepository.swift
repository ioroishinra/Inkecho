import Foundation

@MainActor
public protocol MasteryRepository {
    func masteredWordIDs() throws -> Set<UUID>
    func masteredWords() throws -> [Word]
    func masteredCount() throws -> Int
    func markMastered(wordID: UUID) throws
    func unmarkMastered(wordID: UUID) throws
    func resetAll() throws
}
