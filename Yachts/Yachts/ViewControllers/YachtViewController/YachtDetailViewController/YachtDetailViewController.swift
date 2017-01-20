
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
    if let url = URL(string: model.imageURL) {
      downloadImage(url)
    }

  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, model:YachtRowViewData) {
    self.model = model
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init(model:YachtRowViewData)
  {
    self.init(nibName: "YachtDetailViewController", bundle: Bundle(for: YachtDetailViewController.self), model:model )
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

