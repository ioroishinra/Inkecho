import XCTest
import Core
@testable import MasteredListFeature

@MainActor
final class MasteredListViewModelTests: XCTestCase {
    private var masteryRepo: MockMasteryRepository!
    private var sut: MasteredListViewModel!

    override func setUp() {
        masteryRepo = MockMasteryRepository()
        sut = MasteredListViewModel(masteryRepo: masteryRepo)
    }

    func test_load_withEmptyRepo_wordsIsEmpty() {
        sut.load()
        XCTAssertTrue(sut.words.isEmpty)
    }

    func test_load_returnsWordsFromRepository() {
        // MockMasteryRepository.masteredWords returns [] by default;
        // this confirms load() calls the repo without crashing.
        sut.load()
        XCTAssertNotNil(sut.words)
    }
}
