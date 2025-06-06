// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "NovaUI",
    platforms: [
        .iOS(.v16),
        .macOS(.v11)
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
