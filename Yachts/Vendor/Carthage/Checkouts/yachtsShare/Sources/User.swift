
import Foundation
import SwiftyJSON

public struct User: Identifiable {
  public let id:Identifier
  public let name:String
  public let email:String
  public let avatarURL:String

  // Dictionary Serializers
  static public func deserialize(dictionary:Dictionary<String, Any>) -> User {
    let model = User(
      id: dictionary["id"] as! String,
      name: dictionary["name"] as! String,
      email: dictionary["email"] as! String,
      avatarURL: dictionary["avatarURL"] as! String
    )
    return model
  }

  public func serialize() -> [String: Any] {
    var model = [String: Any]()
    model["id"] = self.id
    model["name"] = self.name
    model["email"] = self.email
    model["avatarURL"] = self.avatarURL
    return model
  }

  //   JSON serializers
  func toJSON() -> JSON {
    return JSON([
      "name": name,
      "email": email,
      "avatarURL": avatarURL
      ])
  }

}

extension User: Equatable {
  static public func ==(lhs: User, rhs:User) -> Bool {
    return lhs.id == rhs.id
  }
}
