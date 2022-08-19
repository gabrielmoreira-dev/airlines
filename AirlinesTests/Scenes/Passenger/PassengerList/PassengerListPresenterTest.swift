@testable import Airlines
import XCTest

private final class PassengerListCoordinatorSpy: PassengerListCoordinating {
    enum Message: Equatable {
        case perform(action: PassengerListAction)
    }
    
    private(set) var messages: [Message] = []
    
    func perform(action: PassengerListAction) {
        messages.append(.perform(action: action))
    }
}

private final class PassengerListViewControllerSpy: PassengerListDisplaying {
    enum Message: Equatable {
        case displayPassengerList(passengers: [PassengerViewModel])
        case displayFooterLoadingState
        case displayLoadingState
        case displayErrorState(title: String, description: String)
    }
    
    private(set) var messages: [Message] = []
    
    func displayPassengerList(_ passengers: [PassengerViewModel]) {
        messages.append(.displayPassengerList(passengers: passengers))
    }
    
    func displayFooterLoadingState() {
        messages.append(.displayFooterLoadingState)
    }
    
    func displayLoadingState() {
        messages.append(.displayLoadingState)
    }
    
    func displayErrorState(_ model: ErrorViewModeling) {
        messages.append(.displayErrorState(title: model.title, description: model.description))
    }
}

final class PassengerListPresenterTest: XCTestCase {
    private lazy var coordinatorSpy = PassengerListCoordinatorSpy()
    private lazy var viewControllerSpy = PassengerListViewControllerSpy()
    private lazy var sut: PassengerListPresenting = {
        let presenter = PassengerListPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
}

extension PassengerListPresenterTest {
    func testPresentPassengerList_WhenCalled_ShouldCallDisplayPassengerList() {
        let passengerList: [Passenger] = .fixture()
        let passengerViewModelList: [PassengerViewModel] = .fixture()
        
        sut.presentPassengerList(passengerList)
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayPassengerList(passengers: passengerViewModelList)])
    }
    
    func testPresentFooterLoadingState_WhenCalled_ShouldCallDisplayLoadingState() {
        sut.presentFooterLoadingState()
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayFooterLoadingState])
    }
    
    func testPresentLoadingState_WhenCalled_ShouldCallDisplayLoadingState() {
        sut.presentLoadingState()
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayLoadingState])
    }
    
    func testPresentErrorState_WhenCalled_ShouldCallDisplayErrorState() {
        let error: ApiError = .serverError
        
        sut.presentErrorState(error: error)
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayErrorState(
            title: Strings.Error.Generic.title,
            description: Strings.Error.Generic.description
        )])
    }
    
    func testPresentPassengerMessage_WhenCalled_ShouldCallCoordinator() {
        let passenger: Passenger = .fixture()
        let action: PassengerListAction = .showMessage(.fixture(passenger: passenger))
        
        sut.presentPassengerMessage(for: passenger)
        
        XCTAssertEqual(coordinatorSpy.messages, [.perform(action: action)])
    }
    
    func testDidNextStep_WhenCalled_ShouldCallCoordinator() {
        let action: PassengerListAction = .showMessage(.fixture())
        
        sut.didNextStep(action: action)
        
        XCTAssertEqual(coordinatorSpy.messages, [.perform(action: action)])
    }
}
