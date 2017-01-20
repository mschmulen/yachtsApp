//
//  Forsale.swift
//
//  Created by Matt Schmulen on 1/20/17
//  Copyright (c) __MyCompanyName__. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Forsale {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let imageURLs = "imageURLs"
    static let name = "name"
    static let id = "id"
    static let currency = "currency"
    static let url = "url"
    static let price = "price"
  }

  // MARK: Properties
  public var imageURLs: [String]?
  public var name: String?
  public var id: String?
  public var currency: String?
  public var url: String?
  public var price: Int?

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
    if let items = json[SerializationKeys.imageURLs].array { imageURLs = items.map { $0.stringValue } }
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].string
    currency = json[SerializationKeys.currency].string
    url = json[SerializationKeys.url].string
    price = json[SerializationKeys.price].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = imageURLs { dictionary[SerializationKeys.imageURLs] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = currency { dictionary[SerializationKeys.currency] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    return dictionary
  }

}
