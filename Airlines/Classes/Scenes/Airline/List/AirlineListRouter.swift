import Foundation

@objc protocol AirlineListRoutingLogic {
}

protocol AirlineListDataPassing {
    var dataStore: AirlineListDataStore { get }
}

class AirlineListRouter: NSObject, AirlineListDataPassing {
    weak var viewController: AirlineListViewController?
    let dataStore: AirlineListDataStore
    
    init(viewController: AirlineListViewController, dataStore: AirlineListDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
      
    //func navigateToSomewhere(source: AirlineListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
      
    //func passDataToSomewhere(source: AirlineListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

extension AirlineListRouter: AirlineListRoutingLogic {
}
