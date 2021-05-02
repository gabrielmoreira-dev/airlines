import Foundation

protocol AirlineListPresentationLogic {
    func presentAirlineList(response: AirlineList.GetAirlineList.Response)
}

class AirlineListPresenter {
    weak var viewController: AirlineListDisplayLogic?
    
    init(viewController: AirlineListDisplayLogic) {
        self.viewController = viewController
    }
}

extension AirlineListPresenter: AirlineListPresentationLogic {
    func presentAirlineList(response: AirlineList.GetAirlineList.Response) {
        let viewModel = AirlineList.GetAirlineList.ViewModel(airlines: response.airlines)
        viewController?.displayAirlineList(viewModel: viewModel)
    }
}
