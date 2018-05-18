// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "apollo-fetcher",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "apollo-fetcher",
            targets: ["apollo-fetcher"]),
        .library(
            name: "apollo-fetcher-storable",
            targets: ["apollo-fetcher-storable"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/lumyk/apollo-mapper.git", .exact("0.0.6")),
        .package(url: "https://github.com/apollographql/apollo-ios.git", from: "0.8.0"),
        .package(url: "https://github.com/Lumyk/sqlite-helper.git", .exact("0.0.7")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "apollo-fetcher",
            dependencies: ["Apollo", "apollo-mapper"]),
        .target(
            name: "apollo-fetcher-storable",
            dependencies: ["apollo-fetcher","sqlite-helper"], path: "Sources/apollo-fetcher-storable/"),
        .testTarget(
            name: "apollo-fetcherTests",
            dependencies: ["apollo-fetcher-storable"]),
    ]
)
