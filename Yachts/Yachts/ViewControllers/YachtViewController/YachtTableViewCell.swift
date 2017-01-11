
import UIKit

class YachtTableViewCell: UITableViewCell, UIReusable {

  @IBOutlet weak var imageThumbnail: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  static let rowHeight:CGFloat = CGFloat(189.0)

  func loadItem(_ model: YachtRowViewData ) {
    titleLabel.text = model.title
    descriptionLabel.text = model.architect
    downloadImage(model.imageURL)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    self.imageThumbnail.image = nil
    titleLabel.text = ""
    descriptionLabel.text = ""
  }

}

// Image loading
extension  YachtTableViewCell {

  func downloadImage(_ url: URL) {
    getDataFromUrl(url) { (data, response, error)  in
      DispatchQueue.main.async { () -> Void in
        guard let data = data , error == nil else {
          return
        }

        self.imageThumbnail.contentMode = .scaleAspectFit
        self.imageThumbnail.image = UIImage(data: data)
      }
    }
  }
}



