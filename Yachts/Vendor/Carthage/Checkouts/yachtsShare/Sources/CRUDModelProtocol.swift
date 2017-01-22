
import SwiftyJSON

public protocol CRUDModel : Identifiable {
  static var keys:[String] { get }
  init(object: Any)
  func dictionaryRepresentation() -> [String: Any]
}
