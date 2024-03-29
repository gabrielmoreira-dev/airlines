protocol AirlineListInteracting {
    func getAirlineList()
    func retry()
}

final class AirlineListInteractor {
    private let presenter: AirlineListPresenting
    private let service: AirlineListServicing
    
    init(presenter: AirlineListPresenting, service: AirlineListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension AirlineListInteractor: AirlineListInteracting {
    func getAirlineList() {
        presenter.presentLoadingState()
        service.fetchAirlineList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let airlines):
                    self.handleSuccess(airlines: airlines)
                case .failure(let error):
                    self.handleError(error)
            }
        }
    }
    
    func retry() {
        getAirlineList()
    }
}

private extension AirlineListInteractor {
    func handleSuccess(airlines: [Airline]) {
        presenter.presentAirlineList(airlines)
    }
    
    func handleError(_ error: ApiError) {
        presenter.presentErrorState(error: error)
    }
}
