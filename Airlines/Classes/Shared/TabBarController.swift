import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstTabViewController = AirlineListFactory.makeController()
        firstTabViewController.tabBarItem = UITabBarItem(title: "Airlines", image: UIImage(systemName: "airplane"), tag: 0)
        
        let secondTabViewController = ViewController()
        secondTabViewController.tabBarItem = UITabBarItem(title: "Passengers", image: UIImage(systemName: "person.fill"), tag: 1)
        
        viewControllers = [
            UINavigationController(rootViewController: firstTabViewController),
            UINavigationController(rootViewController: secondTabViewController)
        ]
    }
}
