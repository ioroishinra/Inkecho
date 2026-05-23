import Foundation

public enum DeckShuffler {
    public static func shuffle<T>(_ elements: [T]) -> [T] {
        var copy = elements
        for i in stride(from: copy.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            copy.swapAt(i, j)
        }
        return copy
    }

    public static func filterUnmastered(_ words: [Word], masteredIDs: Set<UUID>) -> [Word] {
        words.filter { !masteredIDs.contains($0.id) }
    }
}
