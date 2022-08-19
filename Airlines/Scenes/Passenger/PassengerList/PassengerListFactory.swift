import UIKit

final class PassengerListFactory {
    static func make() -> UIViewController {
        let coordinator = PassengerListCoordinator()
        let presenter = PassengerListPresenter(coordinator: coordinator)
        let service = PassengerListService()
        let interactor = PassengerListInteractor(presenter: presenter, service: service)
        let viewController = PassengerListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
