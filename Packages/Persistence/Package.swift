// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Persistence",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [.library(name: "Persistence", targets: ["Persistence"])],
    dependencies: [.package(path: "../Core")],
    targets: [
        .target(name: "Persistence", dependencies: ["Core"],
                path: "Sources/Persistence")
    ]
)
