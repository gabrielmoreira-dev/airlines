import Foundation

protocol PassengerListBusinessLogic {
    func fetchPassengerList(request: PassengerList.GetPassengerList.Request)
}

protocol PassengerListDataStore {
    var passengers: [PassengerList.Passenger] { get set }
}

class PassengerListInteractor: PassengerListDataStore {
    private let presenter: PassengerListPresentationLogic
    private let worker: PassengerListWorker
    var passengers: [PassengerList.Passenger] = []
    
    init(presenter: PassengerListPresentationLogic, worker: PassengerListWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension PassengerListInteractor: PassengerListBusinessLogic {
    func fetchPassengerList(request: PassengerList.GetPassengerList.Request) {
        worker.fetchPassengerList(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let result):
                    self.passengers.append(contentsOf: result.data)
                    let response = PassengerList.GetPassengerList.Response(
                        passengers: self.passengers,
                        nextPage: request.page + 1,
                        size: request.size
                    )
                    self.presenter.presentPassengerList(response: response)
                case .failure(let error):
                    print(error)
                    break
            }
        }
    }
}
