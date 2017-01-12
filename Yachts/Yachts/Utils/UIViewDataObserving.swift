
import ReactiveSwift
import enum Result.NoError

protocol UIViewDataProtocol {
  static var empty: Self { get }
}

extension Optional: UIViewDataProtocol {
  static var empty: Optional {
    return .none
  }
}

extension Array: UIViewDataProtocol {
  static var empty: Array {
    return []
  }
}

protocol UIViewDataObserving: class {
  associatedtype ViewData: UIViewDataProtocol

  var viewData: MutableProperty<ViewData> { get }

  func viewDataDidChange(from old: ViewData, to new: ViewData)
}

extension UIViewDataObserving {

  func observe<P: PropertyProtocol>(_ viewData: P) where P.Value == ViewData {
    self.viewData <~ viewData
  }

  func observeViewDataChanges(until trigger: Signal<(), NoError>) {
    viewData.producer
      .combinePrevious(.empty)
      .take(until: trigger)
      .startWithValues { [weak self] old, new in
        self?.viewDataDidChange(from: old, to: new)
    }
  }
}


