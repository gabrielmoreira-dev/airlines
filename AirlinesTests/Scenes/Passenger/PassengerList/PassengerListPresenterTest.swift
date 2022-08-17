@testable import Airlines
import XCTest

private final class PassengerListCoordinatorSpy: RefactoryPassengerListCoordinating {
    enum Message: Equatable {
        case perform(action: RefactoryPassengerListAction)
    }
    
    private(set) var messages: [Message] = []
    
    func perform(action: RefactoryPassengerListAction) {
        messages.append(.perform(action: action))
    }
}

private final class PassengerListViewControllerSpy: RefactoryPassengerListDisplaying {
    enum Message: Equatable {
    }
    
    private(set) var messages: [Message] = []
}

final class PassengerListPresenterTest: XCTestCase {
    private lazy var coordinatorSpy = PassengerListCoordinatorSpy()
    private lazy var viewControllerSpy = PassengerListViewControllerSpy()
    private lazy var sut: RefactoryPassengerListPresenting = {
        let presenter = RefactoryPassengerListPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
}

extension PassengerListPresenterTest {
    
}
