import UIKit

final class PassengerFlowCoordinator {
    private let navigationController: UINavigationController
    private var viewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = RefactoryPassengerListFactory.make()
        viewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}
