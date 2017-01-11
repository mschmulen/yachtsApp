
import UIKit

class YachtDetailViewController: UIViewController {

  var back: (() -> Void)?

  let model:YachtRowViewData

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var labelName: UILabel! {
    didSet {
      labelName.text = model.title
    }
  }

  @IBOutlet weak var labelArchitect: UILabel! {
    didSet{
      labelArchitect.text = model.architect
    }
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    downloadImage(model.imageURL)
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - init
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, data:YachtRowViewData) {
    self.model = data
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init( data:YachtRowViewData)
  {
    self.init(nibName: "YachtDetailViewController", bundle: Bundle(for: YachtDetailViewController.self), data:data )
  }
}

extension YachtDetailViewController {

  func downloadImage(_ url: URL) {
    getDataFromUrl(url) { (data, response, error)  in
      DispatchQueue.main.async { () -> Void in
        guard let data = data , error == nil else {
          return
        }

        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = UIImage(data: data)
      }
    }
  }
}

