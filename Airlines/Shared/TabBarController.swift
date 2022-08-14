import UIKit

final class TabBarController: UITabBarController {
    private lazy var firstTabController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "Airlines",
            image: UIImage(systemName: "airplane"),
            tag: 0
        )
        
        let coordinator = AirlineFlowCoordinator(navigationController: navigationController)
        coordinator.start()
        
        return navigationController
    }()
    
    private lazy var secondTabController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: "Passengers",
            image: UIImage(systemName: "person.fill"),
            tag: 1
        )
        
        let coordinator = PassengerFlowCoordinator(navigationController: navigationController)
        coordinator.start()
        
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [firstTabController, secondTabController]
    }
}
