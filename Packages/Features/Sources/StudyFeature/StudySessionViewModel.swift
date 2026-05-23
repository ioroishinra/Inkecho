import SwiftUI
import Core
import Persistence

public enum SlideDirection { case none, left, right }

@Observable
@MainActor
public final class StudySessionViewModel {
    public private(set) var deck: [Word] = []
    public private(set) var currentIndex: Int = 0
    public private(set) var isFlipped: Bool = false
    public private(set) var slideDirection: SlideDirection = .none
    public private(set) var masteredCount: Int = 0
    public private(set) var totalCount: Int = 0
    public private(set) var isLoading: Bool = false
    public private(set) var toast: String?

    public var currentCard: Word? { deck.indices.contains(currentIndex) ? deck[currentIndex] : nil }
    public var progress: Double { totalCount > 0 ? Double(masteredCount) / Double(totalCount) : 0 }

    private let wordRepo: any WordRepository
    private let masteryRepo: any MasteryRepository
    private let studyRepo: any StudyRecordRepository

    public init(wordRepo: any WordRepository,
                masteryRepo: any MasteryRepository,
                studyRepo: any StudyRecordRepository) {
        self.wordRepo = wordRepo
        self.masteryRepo = masteryRepo
        self.studyRepo = studyRepo
    }

    public func loadDeck() {
        isLoading = true
        do {
            let all = try wordRepo.fetchAll()
            let masteredIDs = try masteryRepo.masteredWordIDs()
            totalCount = all.count
            masteredCount = masteredIDs.count
            deck = DeckShuffler.shuffle(DeckShuffler.filterUnmastered(all, masteredIDs: masteredIDs))
            currentIndex = 0; isFlipped = false
        } catch { showToast("読み込みエラー") }
        isLoading = false
    }

    public func flip() { guard !isFlipped else { return }; isFlipped = true }

    public func skip() {
        guard let card = currentCard else { return }
        try? studyRepo.record(wordID: card.id, result: .skip)
        advance(direction: .left)
    }

    public func master() {
        guard let card = currentCard else { return }
        try? masteryRepo.markMastered(wordID: card.id)
        try? studyRepo.record(wordID: card.id, result: .mastered)
        masteredCount += 1
        advance(direction: .right)
    }

    public func shuffleAll() {
        guard let words = try? wordRepo.fetchAll() else { return }
        deck = DeckShuffler.shuffle(words)
        currentIndex = 0; isFlipped = false
        showToast("全\(words.count)語でシャッフル")
    }

    public func shuffleUnmastered() {
        guard let all = try? wordRepo.fetchAll(),
              let ids = try? masteryRepo.masteredWordIDs() else { return }
        let unmastered = DeckShuffler.filterUnmastered(all, masteredIDs: ids)
        deck = DeckShuffler.shuffle(unmastered)
        currentIndex = 0; isFlipped = false
        showToast("\(unmastered.count)語（未習得）でシャッフル")
    }

    public func resetProgress() {
        try? masteryRepo.resetAll()
        loadDeck()
        showToast("リセット完了")
    }

    private func advance(direction: SlideDirection) {
        slideDirection = direction
        isFlipped = false
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(270))
            slideDirection = .none
            let next = currentIndex + 1
            if next < deck.count { currentIndex = next } else { loadDeck() }
        }
    }

    private func showToast(_ msg: String) {
        toast = msg
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(2))
            toast = nil
        }
    }
}
