import Testing
@testable import Core

@Suite("DeckShuffler")
struct DeckShufflerTests {
    private func words(_ n: Int) -> [Word] {
        (0..<n).map { i in
            Word(id: .init(), kanji: "語\(i)", reading: "よみ\(i)", meaning: "意味\(i)", example: "例\(i)。", level: 1, category: "wago")
        }
    }

    @Test func preservesAllElements() {
        let original = words(10)
        let shuffled = DeckShuffler.shuffle(original)
        #expect(Set(shuffled.map(\.id)) == Set(original.map(\.id)))
    }

    @Test func preservesCount() {
        #expect(DeckShuffler.shuffle(words(20)).count == 20)
    }

    @Test func emptyRemainsEmpty() {
        #expect(DeckShuffler.shuffle([Word]()).isEmpty)
    }

    @Test func filterUnmasteredExcludesMastered() {
        let ws = words(5)
        let masteredIDs: Set<UUID> = [ws[0].id, ws[2].id]
        let unmastered = DeckShuffler.filterUnmastered(ws, masteredIDs: masteredIDs)
        #expect(unmastered.count == 3)
        #expect(unmastered.allSatisfy { !masteredIDs.contains($0.id) })
    }

    @Test func filterUnmasteredAllMasteredReturnsEmpty() {
        let ws = words(3)
        let all = Set(ws.map(\.id))
        #expect(DeckShuffler.filterUnmastered(ws, masteredIDs: all).isEmpty)
    }
}
