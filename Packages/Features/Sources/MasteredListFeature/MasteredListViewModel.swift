import SwiftUI
import Core

@Observable
@MainActor
public final class MasteredListViewModel {
    public private(set) var words: [Word] = []

    private let masteryRepo: any MasteryRepository

    public init(masteryRepo: any MasteryRepository) { self.masteryRepo = masteryRepo }

    public func load() {
        words = (try? masteryRepo.masteredWords()) ?? []
    }
}
