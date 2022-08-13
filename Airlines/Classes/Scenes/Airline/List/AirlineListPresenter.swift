protocol AirlineListPresenting {
    func presentAirlineList(_ airlines: [Airline])
    func presentLoadingState()
    func presentEndLoadingState()
    func didNextStep(action: AirlineListAction)
}

final class AirlineListPresenter {
    private let coordinator: AirlineListCoordinating
    weak var viewController: AirlineListDisplaying?
    
    init(coordinator: AirlineListCoordinating) {
        self.coordinator = coordinator
    }
}

extension AirlineListPresenter: AirlineListPresenting {
    func presentAirlineList(_ airlines: [Airline]) {
        viewController?.displayAirlineList(airlines)
    }
    
    func presentLoadingState() {
        viewController?.displayLoadingState()
    }
    
    func presentEndLoadingState() {
        viewController?.displayEndLoadingState()
    }
    
    func didNextStep(action: AirlineListAction) {
        coordinator.perform(action: action)
    }
}
