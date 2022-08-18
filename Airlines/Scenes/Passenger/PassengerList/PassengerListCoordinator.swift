import UIKit

enum PassengerListAction: Equatable {
    case showMessage(PassengerMessage)
}

protocol PassengerListCoordinating: AnyObject {
    func perform(action: PassengerListAction)
}

final class PassengerListCoordinator {
    private typealias Localizable = Strings.Passenger.List.Message
    weak var viewController: UIViewController?
}

extension PassengerListCoordinator: PassengerListCoordinating {
    func perform(action: PassengerListAction) {
        switch action {
        case let .showMessage(message):
            showMessage(message)
        }
    }
}

private extension PassengerListCoordinator {
    func showMessage(_ message: PassengerMessage) {
        let alert = UIAlertController(title: message.title, message: message.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.button, style: .default, handler: { action in
            self.viewController?.dismiss(animated: true)
        }))
        viewController?.present(alert, animated: true)
    }
}
