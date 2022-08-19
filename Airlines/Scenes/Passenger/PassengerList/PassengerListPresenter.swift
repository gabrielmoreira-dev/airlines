protocol PassengerListPresenting {
    func presentPassengerList(_ passengers: [Passenger])
    func presentFooterLoadingState()
    func presentLoadingState()
    func presentErrorState(error: ApiError)
    func presentPassengerMessage(for passenger: Passenger)
    func didNextStep(action: PassengerListAction)
}

final class PassengerListPresenter {
    private typealias Localizable = Strings.Passenger.List
    private let coordinator: PassengerListCoordinating
    weak var viewController: PassengerListDisplaying?
    
    init(coordinator: PassengerListCoordinating) {
        self.coordinator = coordinator
    }
}

extension PassengerListPresenter: PassengerListPresenting {
    func presentPassengerList(_ passengers: [Passenger]) {
        let passengerViewModelList = getPassengerViewModelList(from: passengers)
        viewController?.displayPassengerList(passengerViewModelList)
    }
    
    func presentFooterLoadingState() {
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
    
    func didNextStep(action: PassengerListAction) {
        coordinator.perform(action: action)
    }
}

private extension PassengerListPresenter {
    func getPassengerViewModelList(from passengers: [Passenger]) -> [PassengerViewModel] {
        passengers.map {
            PassengerViewModel(
                title: $0.name,
                message: Localizable.Item.description($0.trips)
            )
        }
    }
}
