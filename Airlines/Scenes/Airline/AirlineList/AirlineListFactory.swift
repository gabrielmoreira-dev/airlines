import UIKit

enum AirlineListFactory {
    static func make(with dependencies: DependencyContainer) -> UIViewController {
        let coordinator = AirlineListCoordinator()
        let presenter = AirlineListPresenter(coordinator: coordinator)
        let service = AirlineListService(dependencies: dependencies)
        let interactor = AirlineListInteractor(presenter: presenter, service: service)
        let viewController = AirlineListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
