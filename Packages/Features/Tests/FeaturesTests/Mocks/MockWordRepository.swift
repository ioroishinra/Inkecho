import Foundation
import Core

@MainActor
final class MockWordRepository: WordRepository {
    var words: [Word] = []
    var shouldThrow = false

    func fetchAll() throws -> [Word] {
        if shouldThrow { throw MockError.intentional }
        return words
    }

    func count() throws -> Int {
        if shouldThrow { throw MockError.intentional }
        return words.count
    }
}

enum MockError: Error { case intentional }
