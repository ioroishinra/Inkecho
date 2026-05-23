import Foundation

public struct Word: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let kanji: String
    public let reading: String
    public let meaning: String
    public let example: String
    public let level: Int
    public let category: String

    public init(id: UUID = UUID(), kanji: String, reading: String,
                meaning: String, example: String, level: Int, category: String) {
        self.id = id; self.kanji = kanji; self.reading = reading
        self.meaning = meaning; self.example = example
        self.level = level; self.category = category
    }
}
