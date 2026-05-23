import Testing
@testable import Core

@Suite("SeedLoader")
struct SeedLoaderTests {
    @Test func loadsAllWords() throws {
        let words = try SeedLoader.loadWords()
        #expect(words.count == 151)
    }

    @Test func containsExpectedKanji() throws {
        let words = try SeedLoader.loadWords()
        #expect(words.map(\.kanji).contains("佇む"))
    }

    @Test func allFieldsNonEmpty() throws {
        for word in try SeedLoader.loadWords() {
            #expect(!word.kanji.isEmpty)
            #expect(!word.reading.isEmpty)
            #expect(!word.meaning.isEmpty)
            #expect(!word.example.isEmpty)
            #expect((1...3).contains(word.level))
            #expect(!word.category.isEmpty)
        }
    }

    @Test func allCategoryWago() throws {
        let words = try SeedLoader.loadWords()
        #expect(words.allSatisfy { $0.category == "wago" })
    }
}
