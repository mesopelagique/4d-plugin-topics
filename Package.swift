// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "topic-workflow",
    products: [
        .executable(name: "topic-workflow", targets: ["topic-workflow"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/nvzqz/FileKit.git", from: "6.0.0")
    ],
    targets: [
        .target(
            name: "topic-workflow",
            dependencies: ["FileKit", .product(name: "ArgumentParser", package: "swift-argument-parser")])
    ]
)
