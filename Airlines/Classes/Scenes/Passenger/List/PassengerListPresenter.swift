import Foundation

protocol PassengerListPresentationLogic {
    func presentPassengerList(response: PassengerList.GetPassengerList.Response)
}

class PassengerListPresenter {
    weak var viewController: PassengerListDisplayLogic?
    
    init(viewController: PassengerListDisplayLogic) {
        self.viewController = viewController
    }
}

extension PassengerListPresenter: PassengerListPresentationLogic {
    func presentPassengerList(response: PassengerList.GetPassengerList.Response) {
        let viewModel = PassengerList.GetPassengerList.ViewModel(
            passengers: response.passengers,
            nextPage: response.nextPage,
            size: response.size
        )
        viewController?.displayPassengerList(viewModel: viewModel)
    }
}
