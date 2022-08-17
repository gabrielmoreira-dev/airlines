import UIKit

final class RefactoryPassengerListFactory {
    static func make() -> UIViewController {
        let coordinator = RefactoryPassengerListCoordinator()
        let presenter = RefactoryPassengerListPresenter(coordinator: coordinator)
        let service = RefactoryPassengerListService()
        let interactor = RefactoryPassengerListInteractor(presenter: presenter, service: service)
        let viewController = RefactoryPassengerListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
