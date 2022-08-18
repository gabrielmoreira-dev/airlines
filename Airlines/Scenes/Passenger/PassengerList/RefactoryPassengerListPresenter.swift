protocol RefactoryPassengerListPresenting {
    func presentPassengerList(_ passengers: [Passenger])
    func presenterFooterLoadingState()
    func presentLoadingState()
    func presentErrorState(error: ApiError)
    func presentPassengerMessage(for passenger: Passenger)
    func didNextStep(action: RefactoryPassengerListAction)
}

final class RefactoryPassengerListPresenter {
    private typealias Localizable = Strings.Passenger.List
    private let coordinator: RefactoryPassengerListCoordinating
    weak var viewController: RefactoryPassengerListDisplaying?
    
    init(coordinator: RefactoryPassengerListCoordinating) {
        self.coordinator = coordinator
    }
}

extension RefactoryPassengerListPresenter: RefactoryPassengerListPresenting {
    func presentPassengerList(_ passengers: [Passenger]) {
        let passengerViewModelList = getPassengerViewModelList(from: passengers)
        viewController?.displayPassengerList(passengerViewModelList)
    }
    
    func presenterFooterLoadingState() {
        viewController?.displayFooterLoadingState()
    }
    
    func presentLoadingState() {
        viewController?.displayLoadingState()
    }
    
    func presentErrorState(error: ApiError) {
        let model = ErrorViewModelResolver.resolve(from: error)
        viewController?.displayErrorState(model)
    }
    
    func presentPassengerMessage(for passenger: Passenger) {
        let message = PassengerMessage(
            title: passenger.name,
            description: Localizable.Message.description(passenger.trips)
        )
        coordinator.perform(action: .showMessage(message))
    }
    
    func didNextStep(action: RefactoryPassengerListAction) {
        coordinator.perform(action: action)
    }
}

private extension RefactoryPassengerListPresenter {
    func getPassengerViewModelList(from passengers: [Passenger]) -> [PassengerViewModel] {
        passengers.map {
            PassengerViewModel(
                title: $0.name,
                message: Localizable.Item.description($0.trips)
            )
        }
    }
}
