protocol RefactoryPassengerListInteracting {
    func getPassengerList()
}

final class RefactoryPassengerListInteractor {
    private let presenter: RefactoryPassengerListPresenting
    private let service: RefactoryPassengerListServicing
    
    init(presenter: RefactoryPassengerListPresenting, service: RefactoryPassengerListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension RefactoryPassengerListInteractor: RefactoryPassengerListInteracting {
    func getPassengerList() {
        presenter.presentLoadingState()
        service.fetchPassengerList(next: 0) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case let .success(data):
                    self.handleSuccess(data: data)
                case let .failure(error):
                    self.handleError(error)
            }
        }
    }
}

private extension RefactoryPassengerListInteractor {
    func handleSuccess(data: PassengerPayload) {
        presenter.presentPassengerList()
    }
    
    func handleError(_ error: ApiError) {
         presenter.presentErrorState(error: error)
    }
}
