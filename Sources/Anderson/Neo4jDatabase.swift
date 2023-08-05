import Foundation
import PackStream
import Theo

public typealias Neo4jClient = BoltClient

public class Neo4jDatabase {
  internal let decoder = DictionaryDecoder()

  internal let raw: Neo4jClient

  public init(_ client: Neo4jClient) {
    self.raw = client
  }
}


// MARK: - CRUD

extension Neo4jDatabase {
  // MARK: - Create


  // MARK: - Get

  public func get<N: Neo4jNode>(
    _ nodeType: N.Type,
    properties: [String: PackProtocol] = [:],
    skip: Int = 0,
    limit: Int = 20
  ) async throws -> [N] {
    let nodes = try await raw.get(
      labels: [N.identifier],
      properties: properties,
      skip: UInt64(skip),
      limit: UInt64(limit)
    )

    return try nodes.map { try decoder.decode(N.self, from: $0.properties) }
  }

  public func get<N: Neo4jNode>(_ nodeType: N.Type, id: Int) async throws -> N {
    guard let node = try await raw.get(nodeID: UInt64(id)) else { throw PackError.notPackable }
    return try decoder.decode(N.self, from: node.properties)
  }

  public func get<N: Neo4jNode>(
    _ nodeType: N.Type,
    customId: Neo4jIDType,
    idKey: String = "id"
  ) async throws -> N {
    let node = switch customId {
    case .int(let int):
      try await get(nodeType, properties: [idKey: int], limit: 1).first
    case .string(let string):
      try await get(nodeType, properties: [idKey: string], limit: 1).first
    case .uuid(let uuid):
      try await get(nodeType, properties: [idKey: uuid.uuidString.lowercased()], limit: 1).first
    }

    guard let node else { throw PackError.notPackable }

    return node
  }


  // MARK: - Update


  // MARK: - Delete


}
