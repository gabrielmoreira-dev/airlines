import Foundation

protocol AirlineListBusinessLogic {
    func fetchAirlineList(request: AirlineList.GetAirlineList.Request)
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
    func fetchAirlineList(request: AirlineList.GetAirlineList.Request) {
        worker.fetchAirlineList() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let airlines):
                    let response = AirlineList.GetAirlineList.Response(airlines: airlines)
                    self.presenter.presentAirlineList(response: response)
                case .failure(let error):
                    print(error)
                    break
            }
        }
    }
}
