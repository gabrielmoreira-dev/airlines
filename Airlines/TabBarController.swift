import UIKit

private extension TabBarController {
    enum Item: Int {
        case airlines
        case passengers
    }
}

final class TabBarController: UITabBarController {
    private typealias Localizable = Strings.Navigation
    private let dependencies = DependencyContainer()
    
    private lazy var firstTabController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: Localizable.Airlines.title,
            image: UIImage(systemName: "airplane"),
            tag: Item.airlines.rawValue
        )
        
        let coordinator = AirlineFlowCoordinator(
            navigationController: navigationController,
            dependencies: dependencies
        )
        coordinator.start()
        
        return navigationController
    }()
    
    private lazy var secondTabController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: Localizable.Passengers.title,
            image: UIImage(systemName: "person.fill"),
            tag: Item.passengers.rawValue
        )
        
        let coordinator = PassengerFlowCoordinator(
            navigationController: navigationController,
            dependencies: dependencies
        )
        coordinator.start()
        
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [firstTabController, secondTabController]
    }
}
