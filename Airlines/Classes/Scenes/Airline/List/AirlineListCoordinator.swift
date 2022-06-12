import UIKit

enum AirlineListAction: Equatable {}

protocol AirlineListCoordinating {
    var viewController: UIViewController? { get set }
    func perform(action: AirlineListAction)
}

final class AirlineListCoordinator {
    weak var viewController: UIViewController?
}

extension AirlineListCoordinator: AirlineListCoordinating {
    func perform(action: AirlineListAction) {
        
    }
}
