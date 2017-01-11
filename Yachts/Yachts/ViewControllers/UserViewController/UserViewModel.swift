
import UIKit
import ReactiveSwift
import Result
import Alamofire

public class UserViewModel {

  private let endpoint = "http://127.0.0.1:8090/yachts/"

  private var lastSearchString = ""
  private var models: [Yacht] = []

  private var providerObserver: Disposable?
  public let viewData: MutableProperty<UserViewData> = MutableProperty(.empty)

  public func refetch() {
    fetchYachts(searchString: lastSearchString)
  }

  public func fetchYachts(searchString:String) {

    lastSearchString = searchString
    
    Alamofire.request(endpoint).responseJSON { response in
      if let JSON = response.result.value {

        let response = JSON as! NSDictionary
        if let data = response.object(forKey:"data"), let jsonResult = data as? Array<Dictionary<String,Any>> {
          for yacht in jsonResult {
            self.models.append( Yacht.deserialize(dictionary: yacht))
          }
        }
        self.vend()
      }
    }
    clearModels()
  }

  public func select( item:Identifier ) {
    print("selected item \(item)")
  }

  private func clearModels() {
    self.models.removeAll()
    self.vend()
  }

  private func vend() {
    let allModels: [UserRowViewData] =  models.map({
      UserRowViewData(
        title: $0.name,
        imageURL:URL(string: $0.imageURL) ?? URL(string:"http://nrgene.com/wp-content/plugins/lightbox/images/No-image-found.jpg")!,
        rating:9,
        architect:$0.architect
      )
    }).sorted{$0.title < $1.title }

    let newData = UserViewData(title: "data count \(allModels.count)", list: allModels)

    viewData.modify { value in
      value = newData
    }
  }

}
