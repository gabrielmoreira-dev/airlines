import UIKit

final class AirlineFlowCoordinator {
    private let navigationController: UINavigationController
    private var viewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = AirlineListFactory.make()
        viewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}
