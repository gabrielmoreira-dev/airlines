import UIKit

enum AirlineListAction: Equatable {
    case exit
}

protocol AirlineListCoordinating {
    func perform(action: AirlineListAction)
}

final class AirlineListCoordinator {
    weak var viewController: UIViewController?
}

extension AirlineListCoordinator: AirlineListCoordinating {
    func perform(action: AirlineListAction) {
        
    }
}
