protocol RefactoryPassengerListInteracting {
    func getPassengerList()
    func getMorePassengers()
    func retry()
    func showPasssengerMessage(at index: Int)
}

final class RefactoryPassengerListInteractor {
    private let presenter: RefactoryPassengerListPresenting
    private let service: RefactoryPassengerListServicing
    private var passengers: [Passenger] = []
    private var nextPage: Int?
    
    init(presenter: RefactoryPassengerListPresenting, service: RefactoryPassengerListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension RefactoryPassengerListInteractor: RefactoryPassengerListInteracting {
    func getPassengerList() {
        presenter.presentLoadingState()
        fetchPassengerList()
    }
    
    func getMorePassengers() {
        guard let page = nextPage else { return }
        presenter.presenterFooterLoadingState()
        fetchPassengerList(page: page)
    }
    
    func retry() {
        getPassengerList()
    }
    
    func showPasssengerMessage(at index: Int) {
        let passenger = passengers[index]
        presenter.presentPassengerMessage(for: passenger)
    }
}

private extension RefactoryPassengerListInteractor {
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
        passengers.append(contentsOf: data.passengers)
        nextPage = data.next
        presenter.presentPassengerList(passengers)
    }
    
    func handleError(_ error: ApiError) {
         presenter.presentErrorState(error: error)
    }
}
