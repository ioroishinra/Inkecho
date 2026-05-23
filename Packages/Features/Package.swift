// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "AppShell",           targets: ["AppShell"]),
        .library(name: "StudyFeature",       targets: ["StudyFeature"]),
        .library(name: "MasteredListFeature",targets: ["MasteredListFeature"]),
        .library(name: "StatsFeature",       targets: ["StatsFeature"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../Persistence"),
        .package(path: "../DesignSystem"),
    ],
    targets: [
        .target(name: "StudyFeature",
                dependencies: ["Core","Persistence","DesignSystem"],
                path: "Sources/StudyFeature"),
        .target(name: "MasteredListFeature",
                dependencies: ["Core","Persistence","DesignSystem"],
                path: "Sources/MasteredListFeature"),
        .target(name: "StatsFeature",
                dependencies: ["Core","Persistence","DesignSystem"],
                path: "Sources/StatsFeature"),
        .target(name: "AppShell",
                dependencies: ["StudyFeature","MasteredListFeature","StatsFeature"],
                path: "Sources/AppShell"),
    ]
)
