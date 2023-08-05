import Foundation

public protocol Neo4jNode: Codable, Primitive, Sendable {
  static var identifier: String { get }
}
