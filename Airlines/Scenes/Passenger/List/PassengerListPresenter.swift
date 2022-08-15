import Foundation

protocol PassengerListPresentationLogic {
    func presentPassengerList(response: PassengerList.GetPassengerList.Response)
    func presentMessage(response: PassengerList.ShowMessage.Response)
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
    
    func presentMessage(response: PassengerList.ShowMessage.Response) {
        let viewModel = PassengerList.ShowMessage.ViewModel(
            title: response.passenger.name ?? "",
            message: "The passenger has \(response.passenger.trips ?? 0) trips."
        )
        viewController?.displayMessage(viewModel: viewModel)
    }
}
