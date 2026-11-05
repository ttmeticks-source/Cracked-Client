
 // swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CrackedClient",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "CrackedClient",
            targets: ["CrackedClient"]
        )
    ],
    targets: [
        .executableTarget(name: "CrackedClient")
    ]
)
