protocol PassengerListInteracting {
    func getPassengerList()
    func getMorePassengers()
    func retry()
    func showPasssengerMessage(at index: Int)
}

final class PassengerListInteractor {
    private let presenter: PassengerListPresenting
    private let service: PassengerListServicing
    private var passengerList: [Passenger] = []
    private var nextPage: Int?
    
    init(presenter: PassengerListPresenting, service: PassengerListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension PassengerListInteractor: PassengerListInteracting {
    func getPassengerList() {
        presenter.presentLoadingState()
        fetchPassengerList()
    }
    
    func getMorePassengers() {
        guard let page = nextPage else { return }
        presenter.presentFooterLoadingState()
        fetchPassengerList(page: page)
    }
    
    func retry() {
        getPassengerList()
    }
    
    func showPasssengerMessage(at index: Int) {
        let passenger = passengerList[index]
        presenter.presentPassengerMessage(for: passenger)
    }
}

private extension PassengerListInteractor {
    func fetchPassengerList(page: Int = 0) {
        service.fetchPassengerList(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case let .success(data):
                    self.handleSuccess(data: data)
                case let .failure(error):
                    self.handleError(error)
            }
        }
    }
    
    func handleSuccess(data: PassengerPayload) {
        passengerList.append(contentsOf: data.passengerList)
        nextPage = data.next
        presenter.presentPassengerList(passengerList)
    }
    
    func handleError(_ error: ApiError) {
         presenter.presentErrorState(error: error)
    }
}
