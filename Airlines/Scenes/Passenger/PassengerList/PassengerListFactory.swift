import UIKit

final class PassengerListFactory {
    static func make(with dependencies: DependencyContainer) -> UIViewController {
        let coordinator = PassengerListCoordinator()
        let presenter = PassengerListPresenter(coordinator: coordinator)
        let service = PassengerListService(dependencies: dependencies)
        let interactor = PassengerListInteractor(presenter: presenter, service: service)
        let viewController = PassengerListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
