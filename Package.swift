// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "NovaUI",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "NovaUI",
            targets: ["NovaUI"]
        )
    ],
    targets: [
        .target(
            name: "NovaUI",
            path: "NovaUI.swiftpm/NovaUI"
        )
    ]
)
