import Foundation

class AirlineListFactory {
    static func makeController() -> AirlineListViewController {
        let viewController = AirlineListViewController()
        let presenter = AirlineListPresenter(viewController: viewController)
        let worker = AirlineListWorker()
        let interactor = AirlineListInteractor(presenter: presenter, worker: worker)
        let router = AirlineListRouter(viewController: viewController, dataStore: interactor)
        viewController.configureInterctor(interactor)
        viewController.configureRouter(router)
        return viewController
    }
}
