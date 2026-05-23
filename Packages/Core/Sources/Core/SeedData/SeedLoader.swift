import Foundation

public enum SeedLoader {
    private struct SeedWord: Decodable {
        let kanji: String
        let reading: String
        let meaning: String
        let example: String
        let level: Int
        let category: String
    }

    public static func loadWords() throws -> [Word] {
        guard let url = Bundle.module.url(forResource: "words", withExtension: "json") else {
            throw SeedError.bundleResourceMissing
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder()
            .decode([SeedWord].self, from: data)
            .map { Word(kanji: $0.kanji, reading: $0.reading, meaning: $0.meaning,
                        example: $0.example, level: $0.level, category: $0.category) }
    }

    public enum SeedError: Error {
        case bundleResourceMissing
    }
}
