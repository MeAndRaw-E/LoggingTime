// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LoggingTime",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(
            name: "LoggingTime",
            targets: ["LoggingTime"]
        )
    ],
    targets: [
        .target(
            name: "LoggingTime",
            path: "Sources"
        )
    ]
)
