import Foundation

@objc protocol PassengerListRoutingLogic {
}

protocol PassengerListDataPassing {
    var dataStore: PassengerListDataStore { get }
}

class PassengerListRouter: NSObject, PassengerListDataPassing {
    weak var viewController: PassengerListViewController?
    let dataStore: PassengerListDataStore
    
    init(viewController: PassengerListViewController, dataStore: PassengerListDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
      
    //func navigateToSomewhere(source: PassengerListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
      
    //func passDataToSomewhere(source: PassengerListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

extension PassengerListRouter: PassengerListRoutingLogic {
}
