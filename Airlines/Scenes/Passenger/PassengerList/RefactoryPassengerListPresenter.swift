protocol RefactoryPassengerListPresenting {
    func presentPassengerList()
}

final class RefactoryPassengerListPresenter {
    private let coordinator: RefactoryPassengerListCoordinating
    weak var viewController: RefactoryPassengerListDisplaying?
    
    init(coordinator: RefactoryPassengerListCoordinating) {
        self.coordinator = coordinator
    }
}

extension RefactoryPassengerListPresenter: RefactoryPassengerListPresenting {
    func presentPassengerList() {
        viewController?.displayAirlineList()
    }
}
