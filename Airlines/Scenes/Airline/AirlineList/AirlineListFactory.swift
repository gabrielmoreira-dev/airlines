import UIKit

enum AirlineListFactory {
    static func make() -> UIViewController {
        let coordinator = AirlineListCoordinator()
        let presenter = AirlineListPresenter(coordinator: coordinator)
        let service = AirlineListService()
        let interactor = AirlineListInteractor(presenter: presenter, service: service)
        let viewController = AirlineListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
