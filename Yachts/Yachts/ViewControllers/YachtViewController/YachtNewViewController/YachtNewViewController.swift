
import UIKit

class YachtNewViewController: UIViewController {

  var back: (() -> Void)?
  var save: ((Yacht) -> Void)?
  var cancel: (() -> Void)?

  @IBAction func actionSave(_ sender: Any) {

//    let m = Yacht (
//      id: "123",
//      name: "NewModel",
//      architect: "new architect",
//      url: "http://bluewaterboats.org/valiant-39/",
//      imageURL: "https://s-media-cache-ak0.pinimg.com/236x/e5/62/f2/e562f2ca779b4cdb50f10f97bd3c8b4b.jpg",
//      likes: 0)

    let dictionary = [
      "id": "123",
      "name": "NewModel",
      "architect": "new architect",
      "url": "http://bluewaterboats.org/valiant-39/",
      "imageURL": "https://s-media-cache-ak0.pinimg.com/236x/e5/62/f2/e562f2ca779b4cdb50f10f97bd3c8b4b.jpg",
    ]

    let m = Yacht(object:dictionary)
    //    save?(m)
  }

  @IBAction func actionCancel(_ sender: Any) {
  }

  @IBOutlet weak var image: UIImageView!

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



