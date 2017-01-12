
import UIKit
import ReactiveSwift
import Result

public struct YachtViewData : UIViewDataProtocol {
  var title:String
  let list:[YachtRowViewData]
  
  static var empty: YachtViewData {
    return YachtViewData(title: "~", list: [])
  }
}

public struct YachtRowViewData : UIViewDataProtocol {

  let title:String
  let imageURL:URL
  let rating:Int
  let architect:String

  static var empty: YachtRowViewData {
    return YachtRowViewData(
      title:"AAA",
      imageURL:URL(string: "http://img00.deviantart.net/0fbb/i/2012/362/0/8/sail_boat_png___by_alzstock-d5pgl04.png")!,
      rating:9,
      architect:"Bob"
    )
  }
}

class YachtViewController: UIViewController , UIViewDataObserving {

  var updateSearch: ((String) -> Void)?
  var selectYachtWith: ((Identifier) -> Void)?
  var refresh: (()->Void)?

  @IBOutlet weak var searchView: UIView! {
    didSet {
      searchView.isHidden = !searchEnabled
    }
  }
  @IBOutlet weak var textFieldSearch: UITextField!
  @IBAction func actionSearchEditChanged(_ sender: Any) {
    if let searchTerm = textFieldSearch.text {
      updateSearch?(searchTerm)
    }
  }

  @IBOutlet weak var tableView: UITableView!
  var refreshControl:UIRefreshControl!

  var searchEnabled:Bool = true
  let cellReuseIdentifier: String = "YachtTableViewCell"
  let cellNibName: String = "YachtTableViewCell"

  let viewData: MutableProperty<YachtViewData> = MutableProperty(.empty)
  func viewDataDidChange(from old: YachtViewData, to new: YachtViewData) {
    self.title = viewData.value.title
    tableView.reloadData()
    self.refreshControl.endRefreshing()
  }

  func addTapped() {

    let vc = YachtNewViewController()
    vc.save = { model in
      print( "save: \(model.name) ")
//      vm.new( model )
    }

    if let nav = self.navigationController {
      nav.pushViewController(vc, animated: true)
    }
    else
    {
      self.present(vc, animated: true, completion: nil)
    }

  }

  func pullToRefresh()
  {
    self.refreshControl.beginRefreshing()
    refresh?()
    self.refreshControl.endRefreshing()
  }

  func actionSearch() {
    updateSearch?("")
  }

  // MARK: - init
  required public init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public convenience init()
  {
    self.init(nibName: "YachtViewController", bundle: Bundle(for: YachtViewController.self))
  }

  deinit {
  }

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    //add button
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(YachtViewController.addTapped))
    navigationItem.rightBarButtonItems = [add]


    //configure the tableview
    tableView.dataSource = self
    tableView.delegate = self

    tableView.register (
      UINib(nibName: cellNibName, bundle: Bundle(for: YachtViewController.self)),
      forCellReuseIdentifier: cellReuseIdentifier
    )

    tableView.rowHeight = YachtTableViewCell.rowHeight

    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(YachtViewController.pullToRefresh), for: UIControlEvents.valueChanged)
    tableView.addSubview(refreshControl)
    tableView.reloadData()

    updateSearch?("")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //refresh?()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    viewData.producer.combinePrevious(.empty).startWithValues { old, new in
      self.viewDataDidChange(from: old, to: new)
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension YachtViewController : UITableViewDataSource {

  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewData.value.list.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: YachtTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    let record = viewData.value.list[indexPath.item]
    cell.loadItem( record )
    return cell
  }

}

extension YachtViewController : UITableViewDelegate {

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = YachtDetailViewController(model: viewData.value.list[indexPath.item] )
    if let nav = self.navigationController {
      nav.pushViewController(vc, animated: true)
    }
    else
    {
      self.present(vc, animated: true, completion: nil)
    }
  }
}

extension YachtViewController {

  public static func factoryNav(searchEnabled:Bool = true) -> UINavigationController {
    let title = "Yachts"
    let vm = YachtViewModel()
    let vc = YachtViewController()
    vc.searchEnabled = searchEnabled
    vc.observe(vm.viewData)
    vc.updateSearch = { searchString in
      vm.fetch(searchString: searchString)
    }
    vc.selectYachtWith = { id in
      print( " id\(id)")
    }
    vc.refresh = {
      vm.refetch()
    }

    let nvc = UINavigationController(rootViewController: vc)
    nvc.tabBarItem = UITabBarItem(title: title, image: nil, tag:2)
    //    nvc.tabBarItem.setFAIcon(FAType.faShoppingCart)
    vc.title = title

    return nvc
  }

}
