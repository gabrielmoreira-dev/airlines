import Foundation

protocol AirlineListPresentationLogic {
    func presentSomething(response: AirlineList.GetAirlineList.Response)
}

class AirlineListPresenter {
    weak var viewController: AirlineListDisplayLogic?
    
    init(viewController: AirlineListDisplayLogic) {
        self.viewController = viewController
    }
}

extension AirlineListPresenter: AirlineListPresentationLogic {
    func presentSomething(response: AirlineList.GetAirlineList.Response) {
        let airlines = [
            AirlineList.Airline(name: "example", logo: "", slogan: "slogan")
        ]
        let viewModel = AirlineList.GetAirlineList.ViewModel(airlines: airlines)
        viewController?.displaySomething(viewModel: viewModel)
    }
}
