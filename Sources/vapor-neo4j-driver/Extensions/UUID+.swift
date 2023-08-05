import Foundation

public extension UUID {
  init?(string: String?) {
    guard let string else { return nil }

    let filteredString = String(string.unicodeScalars.filter(CharacterSet.base16.contains))

    guard filteredString.count == 32 else { return nil }

    var uuidString = filteredString

    [8, 12, 16, 20].enumerated().forEach { (index, offset) in
      uuidString.insert("-", at: uuidString.index(uuidString.startIndex, offsetBy: offset + index))
    }

    guard let uuid = UUID(uuidString: uuidString) else { return nil }

    self = uuid
  }
}
