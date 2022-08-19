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
        case displayErrorState(title: String, description: String)
    }
    
    private(set) var messages: [Message] = []
    
    func displayAirlineList(_ airlines: [Airline]) {
        messages.append(.displayAirlineList(airlines))
    }
    
    func displayLoadingState() {
        messages.append(.displayLoadingState)
    }
    
    func displayErrorState(_ model: ErrorViewModeling) {
        messages.append(.displayErrorState(title: model.title, description: model.description))
    }
}

final class AirlineListPresenterTest: XCTestCase {
    private lazy var coordinatorSpy = AirlineListCoordinatorSpy()
    private lazy var viewControllerSpy = AirlineListViewControllerSpy()
    private lazy var sut: AirlineListPresenting = {
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
        let error: ApiError = .serverError
        
        sut.presentErrorState(error: error)
        
        XCTAssertEqual(viewControllerSpy.messages, [.displayErrorState(
            title: Strings.Error.Generic.title,
            description: Strings.Error.Generic.description
        )])
    }
    
    func testDidNextStep_WhenCalled_ShouldCallCoordinator() {
        let action: AirlineListAction = .exit
        
        sut.didNextStep(action: action)
        
        XCTAssertEqual(coordinatorSpy.messages, [.perform(action: action)])
    }
}
