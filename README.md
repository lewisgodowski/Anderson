# Anderson
Native Neo4j driver for Swift, written in Swift

# 🕶 Installation

## Add Anderson to your Swift project 🚀

Anderson uses the [Swift Package Manager](https://swift.org/getting-started/#using-the-package-manager). Add Anderson to your dependencies in your **Package.swift** file:

`.package(url: "https://github.com/lewisgodowski/Anderson.git", branch: "develop")`

Also, don't forget to add the product `"Anderson"` as a dependency for your target.

```swift
.product(name: "Anderson", package: "Anderson"),
```

# 🚲 Basic usage

First, connect to a database:

```swift
import Anderson

let db = try await MongoDatabase.connect(to: "mongodb://localhost/my_database")
```

Vapor users should register the database as a service:

```swift
extension Request {
    public var mongo: MongoDatabase {
        return application.mongo.adoptingLogMetadata([
            "request-id": .string(id)
        ])
    }
}

private struct MongoDBStorageKey: StorageKey {
    typealias Value = MongoDatabase
}

extension Application {
    public var mongo: MongoDatabase {
        get {
            storage[MongoDBStorageKey.self]!
        }
        set {
            storage[MongoDBStorageKey.self] = newValue
        }
    }
    
    public func initializeMongoDB(connectionString: String) throws {
        self.mongo = try MongoDatabase.lazyConnect(to: connectionString)
    }
}
```
