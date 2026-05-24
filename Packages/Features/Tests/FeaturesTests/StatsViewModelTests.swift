import XCTest
import Core
@testable import StatsFeature

@MainActor
final class StatsViewModelTests: XCTestCase {
    private var wordRepo: MockWordRepository!
    private var masteryRepo: MockMasteryRepository!
    private var studyRepo: MockStudyRecordRepository!
    private var sut: StatsViewModel!

    override func setUp() {
        wordRepo = MockWordRepository()
        masteryRepo = MockMasteryRepository()
        studyRepo = MockStudyRecordRepository()
        sut = StatsViewModel(wordRepo: wordRepo, masteryRepo: masteryRepo, studyRepo: studyRepo)
    }

    func test_load_populatesCountsFromRepositories() throws {
        // Arrange
        let word = Word(kanji: "漢", reading: "かん", meaning: "m", example: "e", level: 1, category: "c")
        wordRepo.words = [word]
        masteryRepo.masteredIDs = [word.id]
        try studyRepo.record(wordID: word.id, result: .mastered)

        // Act
        sut.load()

        // Assert
        XCTAssertEqual(sut.totalCount, 1)
        XCTAssertEqual(sut.masteredCount, 1)
        XCTAssertEqual(sut.studiedCount, 1)
    }

    func test_load_withNoWords_allCountsAreZero() {
        sut.load()
        XCTAssertEqual(sut.totalCount, 0)
        XCTAssertEqual(sut.masteredCount, 0)
        XCTAssertEqual(sut.studiedCount, 0)
    }

    func test_unmasteredCount_equalsTotalMinusMastered() {
        // Arrange
        let w1 = Word(kanji: "一", reading: "いち", meaning: "one", example: "e", level: 1, category: "c")
        let w2 = Word(kanji: "二", reading: "に", meaning: "two", example: "e", level: 1, category: "c")
        wordRepo.words = [w1, w2]
        masteryRepo.masteredIDs = [w1.id]

        // Act
        sut.load()

        // Assert
        XCTAssertEqual(sut.unmasteredCount, 1)
    }

    func test_progress_isZeroWhenTotalIsZero() {
        sut.load()
        XCTAssertEqual(sut.progress, 0.0)
    }

    // MARK: - Error handling (try? replacement)

    func test_load_whenWordRepoThrows_totalCountRemainsZero() {
        // Arrange
        wordRepo.shouldThrow = true

        // Act
        sut.load()

        // Assert: totalCount must be 0, not crashed silently
        XCTAssertEqual(sut.totalCount, 0)
    }

    func test_load_whenMasteryRepoThrows_masteredCountRemainsZero() {
        // Arrange
        masteryRepo.shouldThrow = true

        // Act
        sut.load()

        // Assert
        XCTAssertEqual(sut.masteredCount, 0)
    }

    func test_load_whenStudyRepoThrows_studiedCountRemainsZero() {
        // Arrange
        studyRepo.shouldThrow = true

        // Act
        sut.load()

        // Assert
        XCTAssertEqual(sut.studiedCount, 0)
    }
}
