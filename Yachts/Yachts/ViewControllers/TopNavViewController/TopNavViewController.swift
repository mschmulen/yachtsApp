
import UIKit
import ReactiveSwift
import Result

open class TopNavViewController: UITabBarController {

  let userID:Identifier?

  // MARK: - VC Lifecyle
  override open func viewDidLoad() {
    super.viewDidLoad()
  }

  override open func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  // MARK: – init
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, userID:Identifier? ) {
    self.userID = userID
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init( userID:Identifier? ) {

    self.init(nibName: nil, bundle: nil, userID:userID )

    let nvcYachts = YachtViewController.factoryNav(searchEnabled: true)
    let nvcUsers = UserViewController.factoryNav()

    let viewControllers = [nvcYachts, nvcUsers]
    self.viewControllers = viewControllers
  }

}

