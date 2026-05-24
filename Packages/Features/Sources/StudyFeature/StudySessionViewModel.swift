import SwiftUI
import Core
import OSLog
import DesignSystem

private let logger = Logger(subsystem: "WagoRenshuchou", category: "StudySessionViewModel")

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
        do {
            try studyRepo.record(wordID: card.id, result: .skip)
        } catch {
            logger.error("studyRepo.record skip failed: \(error, privacy: .public)")
        }
        advance(direction: .left)
    }

    public func master() {
        guard let card = currentCard else { return }
        do {
            try masteryRepo.markMastered(wordID: card.id)
        } catch {
            logger.error("masteryRepo.markMastered failed: \(error, privacy: .public)")
        }
        do {
            try studyRepo.record(wordID: card.id, result: .mastered)
        } catch {
            logger.error("studyRepo.record mastered failed: \(error, privacy: .public)")
        }
        masteredCount += 1
        advance(direction: .right)
    }

    public func shuffleAll() {
        let words: [Word]
        do {
            words = try wordRepo.fetchAll()
        } catch {
            logger.error("wordRepo.fetchAll failed in shuffleAll: \(error, privacy: .public)")
            return
        }
        deck = DeckShuffler.shuffle(words)
        currentIndex = 0; isFlipped = false
        showToast("全\(words.count)語でシャッフル")
    }

    public func shuffleUnmastered() {
        let all: [Word]
        do {
            all = try wordRepo.fetchAll()
        } catch {
            logger.error("wordRepo.fetchAll failed in shuffleUnmastered: \(error, privacy: .public)")
            return
        }
        let ids: Set<UUID>
        do {
            ids = try masteryRepo.masteredWordIDs()
        } catch {
            logger.error("masteryRepo.masteredWordIDs failed in shuffleUnmastered: \(error, privacy: .public)")
            return
        }
        let unmastered = DeckShuffler.filterUnmastered(all, masteredIDs: ids)
        deck = DeckShuffler.shuffle(unmastered)
        currentIndex = 0; isFlipped = false
        showToast("\(unmastered.count)語（未習得）でシャッフル")
    }

    public func resetProgress() {
        do {
            try masteryRepo.resetAll()
        } catch {
            logger.error("masteryRepo.resetAll failed: \(error, privacy: .public)")
        }
        loadDeck()
        showToast("リセット完了")
    }

    private func advance(direction: SlideDirection) {
        slideDirection = direction
        isFlipped = false
        Task { @MainActor in
            try? await Task.sleep(for: AppAnimation.cardAdvanceDelay)
            slideDirection = .none
            let next = currentIndex + 1
            if next < deck.count { currentIndex = next } else { loadDeck() }
        }
    }

    private func showToast(_ msg: String) {
        toast = msg
        Task { @MainActor in
            try? await Task.sleep(for: AppAnimation.toastDuration)
            toast = nil
        }
    }
}
