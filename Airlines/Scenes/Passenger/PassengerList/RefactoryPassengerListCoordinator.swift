import UIKit

enum RefactoryPassengerListAction: Equatable {

}

protocol RefactoryPassengerListCoordinating: AnyObject {
    func perform(action: RefactoryPassengerListAction)
}

final class RefactoryPassengerListCoordinator {
    weak var viewController: UIViewController?
}

extension RefactoryPassengerListCoordinator: RefactoryPassengerListCoordinating {
    func perform(action: RefactoryPassengerListAction) {
        
    }
}
