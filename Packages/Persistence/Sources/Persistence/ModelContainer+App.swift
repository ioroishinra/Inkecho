import SwiftData

public extension ModelContainer {
    @MainActor
    static func appContainer() throws -> ModelContainer {
        let schema = Schema([WordEntity.self, StudyRecordEntity.self, WordMasteryEntity.self])
        let config = ModelConfiguration(
            schema: schema,
            cloudKitDatabase: .private("iCloud.com.fumi.wagoren")
        )
        return try ModelContainer(for: schema, configurations: [config])
    }

    @MainActor
    static func inMemoryContainer() throws -> ModelContainer {
        let schema = Schema([WordEntity.self, StudyRecordEntity.self, WordMasteryEntity.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try ModelContainer(for: schema, configurations: [config])
    }
}
