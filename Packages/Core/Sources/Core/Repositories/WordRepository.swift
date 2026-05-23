import Foundation

@MainActor
public protocol WordRepository {
    func fetchAll() throws -> [Word]
    func count() throws -> Int
}
