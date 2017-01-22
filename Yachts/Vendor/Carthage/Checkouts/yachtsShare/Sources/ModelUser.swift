

import Foundation
import SwiftyJSON

public struct ModelUser {

  public static let keys = [
    "name",
    "email",
    "id",
    "avatarURL"
  ]

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let email = "email"
    static let id = "id"
    static let avatarURL = "avatarURL"
  }

  // MARK: Properties
  public var name: String?
  public var email: String?
  public var id: String?
  public var avatarURL: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public init(json: JSON) {
    name = json[SerializationKeys.name].string
    email = json[SerializationKeys.email].string
    id = json[SerializationKeys.id].string
    avatarURL = json[SerializationKeys.avatarURL].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = avatarURL { dictionary[SerializationKeys.avatarURL] = value }
    return dictionary
  }

}

// conform to Identifiable
extension ModelUser: Identifiable {
  public var identifier: Identifier {
    get { return self.id! }
    set { self.id = newValue }
  }
}

extension ModelUser: Equatable {
  static public func ==(lhs: ModelUser, rhs:ModelUser) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
