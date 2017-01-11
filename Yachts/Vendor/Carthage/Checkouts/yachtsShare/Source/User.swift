
import Foundation

public struct User: Identifiable {
  public let id:Identifier
  public let name:String
  public let email:String
}

extension User: Equatable {
  static public func ==(lhs: User, rhs:User) -> Bool {
    return lhs.id == rhs.id
  }
}
