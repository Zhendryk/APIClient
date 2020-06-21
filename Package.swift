// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APIClient",
    platforms: [
      .iOS(.v12)
    ],
    products: [
        .library(
            name: "APIClient",
            targets: ["APIClient"]),
    ],
    targets: [
        .target(
            name: "APIClient",
            path: "Source"),
        .testTarget(
            name: "APIClientTests",
            dependencies: ["APIClient"],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)
