import Foundation

class PassengerListFactory {
    static func makeController() -> PassengerListViewController {
        let viewController = PassengerListViewController()
        let presenter = PassengerListPresenter(viewController: viewController)
        let worker = PassengerListWorker()
        let interactor = PassengerListInteractor(presenter: presenter, worker: worker)
        viewController.configureInterctor(interactor)
        return viewController
    }
}
