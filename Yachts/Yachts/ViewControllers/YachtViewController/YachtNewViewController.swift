
import UIKit

class YachtNewViewController: UIViewController {

  var back: (() -> Void)?
  var save: ((Yacht) -> Void)?
  var cancel: (() -> Void)?

  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - init
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, model:String) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init()
  {
    self.init(nibName: "YachtNewViewController", bundle: Bundle(for: YachtNewViewController.self), model:"String" )
  }
}



