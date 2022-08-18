import UIKit

enum RefactoryPassengerListAction: Equatable {
    case showMessage(PassengerMessage)
}

protocol RefactoryPassengerListCoordinating: AnyObject {
    func perform(action: RefactoryPassengerListAction)
}

final class RefactoryPassengerListCoordinator {
    private typealias Localizable = Strings.Passenger.List.Message
    weak var viewController: UIViewController?
}

extension RefactoryPassengerListCoordinator: RefactoryPassengerListCoordinating {
    func perform(action: RefactoryPassengerListAction) {
        switch action {
        case let .showMessage(message):
            showMessage(message)
        }
    }
}

private extension RefactoryPassengerListCoordinator {
    func showMessage(_ message: PassengerMessage) {
        let alert = UIAlertController(title: message.title, message: message.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.button, style: .default, handler: { action in
            self.viewController?.dismiss(animated: true)
        }))
        viewController?.present(alert, animated: true)
    }
}
