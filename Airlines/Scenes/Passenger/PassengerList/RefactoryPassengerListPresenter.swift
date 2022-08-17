protocol RefactoryPassengerListPresenting {
    func presentPassengerList()
    func presentLoadingState()
    func presentErrorState(error: ApiError)
    func didNextStep(action: RefactoryPassengerListAction)
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
    
    func presentLoadingState() {
        viewController?.displayLoadingState()
    }
    
    func presentErrorState(error: ApiError) {
        let model = ErrorViewModelResolver.resolve(from: error)
        viewController?.displayErrorState(model)
    }
    
    func didNextStep(action: RefactoryPassengerListAction) {
        coordinator.perform(action: action)
    }
}
