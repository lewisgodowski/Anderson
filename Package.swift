// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "vapor-neo4j-driver",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
  ],
  products: [
    .library(name: "Anderson", targets: ["vapor-neo4j-driver"])
  ],
  dependencies: [
    // 🕸️
    .package(
      url: "https://github.com/lewisgodowski/Neo4j-swift.git",
      branch: "develop/async-await"
    ),

    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
  ],
  targets: [
    .target(
      name: "vapor-neo4j-driver",
      dependencies: [.product(name: "Theo", package: "Neo4j-swift")]
    ),
    .testTarget(
      name: "vapor-neo4j-driverTests",
      dependencies: [
        "vapor-neo4j-driver",
        .product(name: "XCTVapor", package: "vapor")
      ]
    )
  ]
)
