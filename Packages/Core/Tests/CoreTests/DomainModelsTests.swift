import Testing
@testable import Core

@Suite("Word")
struct WordTests {
    @Test func equalWhenSameID() {
        let id = UUID()
        let w1 = Word(id: id, kanji: "揺らぐ", reading: "ゆらぐ", meaning: "动摇", example: "例。", level: 2, category: "wago")
        let w2 = Word(id: id, kanji: "揺らぐ", reading: "ゆらぐ", meaning: "动摇", example: "例。", level: 2, category: "wago")
        #expect(w1 == w2)
    }

    @Test func differentWhenDifferentIDs() {
        let w1 = Word(id: .init(), kanji: "揺らぐ", reading: "ゆらぐ", meaning: "动摇", example: "例。", level: 2, category: "wago")
        let w2 = Word(id: .init(), kanji: "揺らぐ", reading: "ゆらぐ", meaning: "动摇", example: "例。", level: 2, category: "wago")
        #expect(w1 != w2)
    }

    @Test func levelInValidRange() {
        let w = Word(id: .init(), kanji: "揺らぐ", reading: "ゆらぐ", meaning: "动摇", example: "例。", level: 2, category: "wago")
        #expect((1...3).contains(w.level))
    }
}

@Suite("StudyResult")
struct StudyResultTests {
    @Test func skipRawValue() { #expect(StudyResult.skip.rawValue == "skip") }
    @Test func masteredRawValue() { #expect(StudyResult.mastered.rawValue == "mastered") }

    @Test func roundTripsFromRawValue() {
        #expect(StudyResult(rawValue: "mastered") == .mastered)
        #expect(StudyResult(rawValue: "skip") == .skip)
        #expect(StudyResult(rawValue: "unknown") == nil)
    }
}
