
import SwiftyJSON

public typealias Identifier = String

public protocol Identifiable: Hashable {
  //  var id: Identifier { get }
  var identifier: Identifier { get set }
}

extension Identifiable {
  public var hashValue: Int {
    return identifier.hashValue
  }
}
