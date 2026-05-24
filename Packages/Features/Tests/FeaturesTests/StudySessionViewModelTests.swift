import XCTest
import Core
@testable import StudyFeature

@MainActor
final class StudySessionViewModelTests: XCTestCase {
    private var wordRepo: MockWordRepository!
    private var masteryRepo: MockMasteryRepository!
    private var studyRepo: MockStudyRecordRepository!
    private var sut: StudySessionViewModel!

    private func makeWord(_ kanji: String) -> Word {
        Word(kanji: kanji, reading: "r", meaning: "m", example: "e", level: 1, category: "c")
    }

    override func setUp() {
        wordRepo = MockWordRepository()
        masteryRepo = MockMasteryRepository()
        studyRepo = MockStudyRecordRepository()
        sut = StudySessionViewModel(wordRepo: wordRepo, masteryRepo: masteryRepo, studyRepo: studyRepo)
    }

    func test_loadDeck_populatesDeckWithUnmasteredWords() {
        // Arrange
        let w1 = makeWord("一")
        let w2 = makeWord("二")
        wordRepo.words = [w1, w2]
        masteryRepo.masteredIDs = [w1.id]

        // Act
        sut.loadDeck()

        // Assert
        XCTAssertEqual(sut.deck.count, 1)
        XCTAssertEqual(sut.deck.first?.kanji, w2.kanji)
    }

    func test_loadDeck_setsTotalAndMasteredCounts() {
        // Arrange
        let w1 = makeWord("三")
        let w2 = makeWord("四")
        wordRepo.words = [w1, w2]
        masteryRepo.masteredIDs = [w1.id]

        // Act
        sut.loadDeck()

        // Assert
        XCTAssertEqual(sut.totalCount, 2)
        XCTAssertEqual(sut.masteredCount, 1)
    }

    func test_flip_setsIsFlippedToTrue() {
        wordRepo.words = [makeWord("五")]
        sut.loadDeck()
        sut.flip()
        XCTAssertTrue(sut.isFlipped)
    }

    func test_flip_doesNothingWhenAlreadyFlipped() {
        wordRepo.words = [makeWord("六")]
        sut.loadDeck()
        sut.flip()
        sut.flip()
        XCTAssertTrue(sut.isFlipped)
    }

    func test_skip_recordsSkipResult() {
        // Arrange
        wordRepo.words = [makeWord("七")]
        sut.loadDeck()

        // Act
        sut.skip()

        // Assert
        XCTAssertEqual(studyRepo.recordedResults.count, 1)
        XCTAssertEqual(studyRepo.recordedResults.first?.1, .skip)
    }

    func test_master_incrementsMasteredCount() {
        // Arrange
        wordRepo.words = [makeWord("八")]
        sut.loadDeck()
        let before = sut.masteredCount

        // Act
        sut.master()

        // Assert
        XCTAssertEqual(sut.masteredCount, before + 1)
    }

    func test_master_recordsMasteredResult() {
        wordRepo.words = [makeWord("九")]
        sut.loadDeck()
        sut.master()
        XCTAssertEqual(studyRepo.recordedResults.first?.1, .mastered)
    }

    func test_progress_isZeroWhenNothingMastered() {
        wordRepo.words = [makeWord("十"), makeWord("百")]
        sut.loadDeck()
        XCTAssertEqual(sut.progress, 0.0)
    }
}
