protocol RefactoryPassengerListInteracting {
    func getPassengerList()
    func getMorePassengers()
    func retry()
}

final class RefactoryPassengerListInteractor {
    private let presenter: RefactoryPassengerListPresenting
    private let service: RefactoryPassengerListServicing
    private var passengers: [Passenger] = []
    private var nextPage: Int? = 0
    
    init(presenter: RefactoryPassengerListPresenting, service: RefactoryPassengerListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension RefactoryPassengerListInteractor: RefactoryPassengerListInteracting {
    func getPassengerList() {
        presenter.presentLoadingState()
        service.fetchPassengerList(page: nextPage ?? 0) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case let .success(data):
                    self.handleSuccess(data: data)
                case let .failure(error):
                    self.handleError(error)
            }
        }
    }
    
    func getMorePassengers() {
        guard let _ = nextPage else { return }
        getPassengerList()
    }
    
    func retry() {
        getPassengerList()
    }
}

private extension RefactoryPassengerListInteractor {
    func handleSuccess(data: PassengerPayload) {
        passengers.append(contentsOf: data.passengers)
        nextPage = data.next
        presenter.presentPassengerList(passengers)
    }
    
    func handleError(_ error: ApiError) {
         presenter.presentErrorState(error: error)
    }
}
