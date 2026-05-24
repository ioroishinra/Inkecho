import SwiftData

public extension ModelContainer {
    @MainActor
    static func appContainer() throws -> ModelContainer {
        let schema = Schema([WordEntity.self, StudyRecordEntity.self, WordMasteryEntity.self])
        // Local persistent store only — CloudKit requires Developer Portal setup
        // (create iCloud.com.fumi.wagoren container, link App ID, add capability in Xcode)
        // To enable sync later: replace ModelConfiguration(schema:) with
        //   ModelConfiguration(schema: schema, cloudKitDatabase: .private("iCloud.com.fumi.wagoren"))
        // and ensure all @Model properties are optional or have default values.
        let config = ModelConfiguration(schema: schema)
        return try ModelContainer(for: schema, configurations: [config])
    }

    @MainActor
    static func inMemoryContainer() throws -> ModelContainer {
        let schema = Schema([WordEntity.self, StudyRecordEntity.self, WordMasteryEntity.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        return try ModelContainer(for: schema, configurations: [config])
    }
}
