import SwiftUI
import Core
import OSLog

private let logger = Logger(subsystem: "WagoRenshuchou", category: "MasteredListViewModel")

@Observable
@MainActor
public final class MasteredListViewModel {
    public private(set) var words: [Word] = []

    private let masteryRepo: any MasteryRepository

    public init(masteryRepo: any MasteryRepository) { self.masteryRepo = masteryRepo }

    public func load() {
        do {
            words = try masteryRepo.masteredWords()
        } catch {
            logger.error("masteryRepo.masteredWords failed: \(error, privacy: .public)")
            words = []
        }
    }
}
