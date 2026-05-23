import SwiftData
import Foundation

@Model
final class WordMasteryEntity {
    var masteryID: UUID
    var masteredAt: Date
    var word: WordEntity?

    init(word: WordEntity) {
        self.masteryID = UUID()
        self.word = word
        self.masteredAt = .now
    }
}
