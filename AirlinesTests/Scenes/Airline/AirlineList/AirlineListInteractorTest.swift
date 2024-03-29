@testable import Airlines
import XCTest

private final class AirlineListServiceStub: AirlineListServicing {
    var fetchAirlineListResult: Result<[Airline], ApiError> = .failure(.emptyData)
    
    func fetchAirlineList(completion: @escaping AirlineListCompletion) {
        completion(fetchAirlineListResult)
    }
}

private final class AirlineListPresenterSpy: AirlineListPresenting {
    enum Message: Equatable {
        case presentAirlineList(airlines: [Airline])
        case presentLoadingState
        case presentErrorState(error: ApiError)
        case didNextStep(action: AirlineListAction)
    }
    
    private(set) var messages: [Message] = []
    
    func presentAirlineList(_ airlines: [Airline]) {
        messages.append(.presentAirlineList(airlines: airlines))
    }
    
    func presentLoadingState() {
        messages.append(.presentLoadingState)
    }
    
    func presentErrorState(error: ApiError) {
        messages.append(.presentErrorState(error: error))
    }
    
    func didNextStep(action: AirlineListAction) {
        messages.append(.didNextStep(action: action))
    }
}

final class AirlineListInteractorTest: XCTestCase {
    private let airlineList: [Airline] = .fixture()
    private lazy var serviceStub = AirlineListServiceStub()
    private lazy var presenterSpy = AirlineListPresenterSpy()
    private lazy var sut = AirlineListInteractor(presenter: presenterSpy, service: serviceStub)
}

// MARK: - Get airline list tests
extension AirlineListInteractorTest {
    func testGetAirlineList_WhenSucceed_ShouldCallPresentAirlineList() {
        serviceStub.fetchAirlineListResult = .success(airlineList)
        
        sut.getAirlineList()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentAirlineList(airlines: airlineList)
        ])
    }
    
    func testGetAirlineList_WhenFailed_ShouldCallPresentErrorState() {
        let error: ApiError = .emptyData
        serviceStub.fetchAirlineListResult = .failure(error)
        
        sut.getAirlineList()
        
        XCTAssertEqual(presenterSpy.messages, [.presentLoadingState, .presentErrorState(error: error)])
    }
}

// MARK: - Retry tests
extension AirlineListInteractorTest {
    func testRetry_WhenSucceed_ShouldCallPresentAirlineList() {
        serviceStub.fetchAirlineListResult = .success(airlineList)
        
        sut.retry()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentAirlineList(airlines: airlineList)
        ])
    }
    
    func testRetry_WhenFailed_ShouldCallPresentErrorState() {
        let error: ApiError = .emptyData
        serviceStub.fetchAirlineListResult = .failure(error)
        
        sut.retry()
        
        XCTAssertEqual(presenterSpy.messages, [.presentLoadingState, .presentErrorState(error: error)])
    }
}
