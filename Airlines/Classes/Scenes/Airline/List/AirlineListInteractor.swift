import Foundation

protocol AirlineListBusinessLogic {
    func doSomething(request: AirlineList.GetAirlineList.Request)
}

protocol AirlineListDataStore {
    //var name: String { get set }
}

class AirlineListInteractor: AirlineListDataStore {
    private let presenter: AirlineListPresentationLogic
    private let worker: AirlineListWorker
    //var name: String = ""
    
    init(presenter: AirlineListPresentationLogic, worker: AirlineListWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension AirlineListInteractor: AirlineListBusinessLogic {
    func doSomething(request: AirlineList.GetAirlineList.Request) {
        worker.doSomeWork()
        
        let response = AirlineList.GetAirlineList.Response()
        presenter.presentSomething(response: response)
    }
}
