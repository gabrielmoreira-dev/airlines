@testable import Airlines
import XCTest

private final class AirlineListCoordinatorSpy: AirlineListCoordinating {
    enum Message: Equatable {
        case perform(action: AirlineListAction)
    }
    
    private(set) var messages: [Message] = []
    
    func perform(action: AirlineListAction) {
        messages.append(.perform(action: action))
    }
}

private final class AirlineListViewControllerSpy: AirlineListDisplaying {
    enum Message: Equatable {
        case displayAirlineList([Airline])
        case displayLoadingState
        case displayError
    }
    
    private(set) var messages: [Message] = []
    
    func displayAirlineList(_ airlines: [Airline]) {
        messages.append(.displayAirlineList(airlines))
    }
    
    func displayLoadingState() {
        messages.append(.displayLoadingState)
    }
    
    func displayErrorState() {
        messages.append(.displayError)
    }
}

final class AirlineListPresenterTest: XCTestCase {
    private lazy var coordinatorSpy = AirlineListCoordinatorSpy()
    private lazy var viewControllerSpy = AirlineListViewControllerSpy()
    private lazy var sut: AirlineListPresenter = {
        let presenter = AirlineListPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
}

extension AirlineListPresenterTest {
    func testPresentAirlineList_WhenCalled_ShouldCallDisplayAirlineList() {
        let airlines: [Airline] = .fixture()
        
        sut.presentAirlineList(airlines)
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayAirlineList(airlines)])
    }
    
    func testPresentLoadingState_WhenCalled_ShouldCallDisplayLoadingState() {
        sut.presentLoadingState()
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayLoadingState])
    }
    
    func testPresentErrorState_WhenCalled_ShouldCallDisplayErrorState() {
        sut.presentErrorState()
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayError])
    }
    
    func testDidNextStep_WhenCalled_ShouldCallCoordinator() {
        let action: AirlineListAction = .exit
        
        sut.didNextStep(action: action)
        
        XCTAssertEqual(coordinatorSpy.messages, [.perform(action: action)])
    }
}
