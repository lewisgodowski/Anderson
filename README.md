# Anderson
Native Neo4j driver for Swift, written in Swift

# 🕶 Installation

## Add Anderson to your Swift project 🚀

Anderson uses the [Swift Package Manager](https://swift.org/getting-started/#using-the-package-manager). Add Anderson to your dependencies in your **Package.swift** file:

```swift
.package(url: "https://github.com/lewisgodowski/Anderson.git", branch: "develop")
```

Also, don't forget to add the product `"Anderson"` as a dependency for your target.

```swift
.product(name: "Anderson", package: "Anderson"),
```

# 🚲 Basic usage

First, connect to a database:

```swift
import Anderson

try await app.initializeNeo4j(
  hostname: <hostname>,
  port: <port>,
  username: <username>,
  password: <password>,
  encrypted: <encrypted>
)
```

Vapor users should register the database as a service:

```swift
import Anderson

extension Request {
  public var neo4j: Neo4jDatabase {
    application.neo4j
  }
}

private struct Neo4jStorageKey: StorageKey {
  typealias Value = Neo4jDatabase
}

extension Application {
  public var neo4j: Neo4jDatabase {
    get {
      storage[Neo4jStorageKey.self]!
    }
    set {
      storage[Neo4jStorageKey.self] = newValue
    }
  }

  public func initializeNeo4j(
    hostname: String,
    port: Int,
    username: String,
    password: String,
    encrypted: Bool
  ) async throws {
    let client = try Neo4jClient(
      hostname: hostname,
      port: port,
      username: username,
      password: password,
      encrypted: encrypted
    )
    try await client.connect()
    neo4j = Neo4jDatabase(client)
  }
}
```
