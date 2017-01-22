
import Foundation
import SwiftyJSON

public struct ModelYacht {

  public static let keys = [
    "imageURL",
    "architect",
    "name",
    "id",
    "likes",
    "url"
  ]

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let imageURL = "imageURL"
    static let architect = "architect"
    static let name = "name"
    static let id = "id"
    static let likes = "likes"
    static let url = "url"
  }

  // MARK: Properties
  public var imageURL: String?
  public var architect: String?
  public var name: String?
  public var id: String?
  public var likes: Int?
  public var url: String?

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
    imageURL = json[SerializationKeys.imageURL].string
    architect = json[SerializationKeys.architect].string
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].string
    likes = json[SerializationKeys.likes].int
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = imageURL { dictionary[SerializationKeys.imageURL] = value }
    if let value = architect { dictionary[SerializationKeys.architect] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = likes { dictionary[SerializationKeys.likes] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

}

// conform to Identifiable
extension ModelYacht: Identifiable {
  public var identifier: Identifier {
    get { return self.id! }
    set { self.id = newValue }
  }
}

extension ModelYacht: Equatable {
  static public func ==(lhs: ModelYacht, rhs:ModelYacht) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
