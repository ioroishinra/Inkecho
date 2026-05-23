import SwiftData
import Foundation

@Model
final class WordEntity {
    var wordID: UUID
    var kanji: String
    var reading: String
    var meaning: String
    var example: String
    var level: Int
    var category: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \StudyRecordEntity.word)
    var studyRecords: [StudyRecordEntity]?

    @Relationship(deleteRule: .cascade, inverse: \WordMasteryEntity.word)
    var mastery: WordMasteryEntity?

    init(wordID: UUID = UUID(), kanji: String, reading: String,
         meaning: String, example: String, level: Int, category: String) {
        self.wordID = wordID; self.kanji = kanji; self.reading = reading
        self.meaning = meaning; self.example = example
        self.level = level; self.category = category
        self.createdAt = .now
    }

    func toDomain() -> Word {
        Word(id: wordID, kanji: kanji, reading: reading,
             meaning: meaning, example: example, level: level, category: category)
    }
}
