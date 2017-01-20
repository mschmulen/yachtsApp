
import UIKit

protocol ViewInitializing {
  func configure()
  func buildUserInterface()
  func activateDefaultLayout()
}

extension UIView: ViewInitializing {
  func configure() {}
  func buildUserInterface() {}
  func activateDefaultLayout() {}
}
