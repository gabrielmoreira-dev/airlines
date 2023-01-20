import UIKit

final class PassengerFlowCoordinator {
    private let navigationController: UINavigationController
    private let dependencies: DependencyContainer
    private var viewController: UIViewController?
    
    init(navigationController: UINavigationController, dependencies: DependencyContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let controller = PassengerListFactory.make(with: dependencies)
        viewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}
