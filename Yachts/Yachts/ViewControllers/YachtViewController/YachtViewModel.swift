
import UIKit
import ReactiveSwift
import Result
import Alamofire

public class YachtViewModel {

  internal let endpointModelRoot = "http://127.0.0.1:8090/yachts/"

  private var lastSearchString = ""
  internal var models: [Yacht] = []

  private var providerObserver: Disposable?
  public let viewData: MutableProperty<YachtViewData> = MutableProperty(.empty)

  public func refetch() {
    fetch(searchString: lastSearchString)
  }

  //fetch all models
  public func fetch(searchString:String) {
    lastSearchString = searchString
    getAll()
  }

  public func select( id:Identifier ) {
    print("selected item \(id)")
    getModel(id:id)
  }

  internal func clearModels() {
    self.models.removeAll()
    //self.vend()
  }

  internal func vend() {
    let allModels: [YachtRowViewData] =  models.map({
      YachtRowViewData(
        id: $0.id ?? "~",
        title: $0.name ?? "~",
        imageURL: $0.imageURL ?? "http://nrgene.com/wp-content/plugins/lightbox/images/No-image-found.jpg",
        rating:9,
        architect:$0.architect ?? "~"
      )
    }).sorted{$0.title < $1.title }

    let newData = YachtViewData(title: "Yachts \(allModels.count)", list: allModels)

    viewData.modify { value in
      value = newData
    }
  }

}

// Network Methods
extension YachtViewModel {

  // router.get("/yachts", handler: yachtService.getAll)
  public func getAll() {

    self.clearModels()
    Alamofire.request(endpointModelRoot).responseJSON { response in

//      switch(response.result) {
//      case .failure(_):
//        print(response.result.debugDescription)
//      case .success(_):
//        break
//      }

      if let JSON = response.result.value {

        let response = JSON as! NSDictionary

        if let data = response.object(forKey:"data") {
          if let jsonResult = data as? Array<Dictionary<String,Any>> {
            for record in jsonResult {
              let anyDictionary = record as Any
              let model = Yacht(object: anyDictionary)
              //User.deserialize(dictionary: record)
              self.models.append(model)
            }
          }
        }
        self.vend()
      }
    }

  }

  //router.get("/yachts/:id", handler:  yachtService.getModel)
  public func getModel(id:Identifier) {
    let endpoint = "\(endpointModelRoot)\(id)"
    Alamofire.request(endpoint).responseJSON { response in
      if let JSON = response.result.value {

        // MAS TODO verify
        let response = JSON as! NSDictionary
        if let data = response.object(forKey:"data") {
          if let jsonResult = data as? Array<Dictionary<String,Any>> {
            for record in jsonResult {
              print( "record \(record)")
              //self.models.append( Yacht.deserialize(dictionary: record))
            }
          }
        }
        //self.vend()
      }
    }
  }
  
  // router.post("/yachts", handler: yachtService.postCreate) // rename postCreate
  public func postCreate(model:Yacht) {

    // MAS TODO move to shared
    let parameters = [
      "name": model.name,
      "architect": model.architect,
      "url": model.url
    ]

    //encoding: JSONEncoding.default
    //headers: nil
    Alamofire.request(endpointModelRoot, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
      switch(response.result) {
      case .success(_):
        print( "success")
        break
      case .failure(_):
        print( "fail")
        print(response.result.debugDescription)
        break
      }
    }
  }

  public func delete( id:Identifier ) {
    let endpoint = "\(endpointModelRoot)\(id)"

    print("endpoint \(endpoint)")
    Alamofire.request(endpoint, method: HTTPMethod.delete, parameters: nil).validate().responseJSON { response in

      switch(response.result) {
      case .success(_):
        print( "success")
        break
      case .failure(_):
        print( "fail")
        break
      }

      if let JSON = response.result.value {
        print( JSON )
      }

      self.getAll()
    }
  }

  //   router.post("/yachts", handler: yachtService.postCreate) // rename postCreate
  public func postUpdate( item:Identifier )
  {
    // MAS TODO
    print("postUpdate item \(item)")
  }

  //router.put("/yachts", handler: yachtService.putModel) // formerly .updateModel)
  // Update an existing model instance or insert a new one in the datastore
  public func putUpdate( item:Identifier )
  {
    // MAS TODO
    print("putUpdate item \(item)")
  }

  //router.put("/yachts/:id", handler:  yachtService.putUpdateModel)
  // Update attributes for a model instance and persist in the datastore
  public func putUpdateWithId( item:Identifier )
  {
    // MAS TODO
    print("putUpdateWithId \(item)")
  }



}
