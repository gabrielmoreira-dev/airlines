import UIKit

final class TabBarController: UITabBarController {
    private lazy var firstTabViewController: UIViewController = {
        let viewController = AirlineListFactory.make()
        viewController.tabBarItem = UITabBarItem(
            title: "Airlines",
            image: UIImage(systemName: "airplane"),
            tag: 0
        )
        return viewController
    }()
    
    private lazy var secondTabViewController: UIViewController = {
        let viewController = PassengerListFactory.makeController()
        viewController.tabBarItem = UITabBarItem(
            title: "Passengers",
            image: UIImage(systemName: "person.fill"),
            tag: 1
        )
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            UINavigationController(rootViewController: firstTabViewController),
            UINavigationController(rootViewController: secondTabViewController)
        ]
    }
}
