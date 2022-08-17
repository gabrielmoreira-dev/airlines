protocol RefactoryPassengerListInteracting {
    
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
    
}
