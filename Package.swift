// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Anderson",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
  ],
  products: [
    .library(name: "Anderson", targets: ["Anderson"])
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
      name: "Anderson",
      dependencies: [.product(name: "Theo", package: "Neo4j-swift")]
    ),
    .testTarget(
      name: "AndersonTests",
      dependencies: [
        "Anderson",
        .product(name: "XCTVapor", package: "vapor")
      ]
    )
  ]
)
