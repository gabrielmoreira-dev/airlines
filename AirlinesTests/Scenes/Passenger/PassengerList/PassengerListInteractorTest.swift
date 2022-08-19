@testable import Airlines
import XCTest

private final class PassengerListServiceStub: PassengerListServicing {
    var fetchPassengerListResult: Result<PassengerPayload, ApiError> = .failure(.emptyData)
    
    func fetchPassengerList(page: Int, completion: @escaping PassengerListCompletion) {
        completion(fetchPassengerListResult)
    }
}

private final class PassengerListPresenterSpy: PassengerListPresenting {
    enum Message: Equatable {
        case presentPassengerList(passengerList: [Passenger])
        case presentFooterLoadingState
        case presentLoadingState
        case presentErrorState(error: ApiError)
        case presentPassengerMessage(passenger: Passenger)
        case didNextStep(action: PassengerListAction)
    }
    
    private(set) var messages: [Message] = []
    
    func presentPassengerList(_ passengerList: [Passenger]) {
        messages.append(.presentPassengerList(passengerList: passengerList))
    }
    
    func presentFooterLoadingState() {
        messages.append(.presentFooterLoadingState)
    }
    
    func presentLoadingState() {
        messages.append(.presentLoadingState)
    }
    
    func presentErrorState(error: ApiError) {
        messages.append(.presentErrorState(error: error))
    }
    
    func presentPassengerMessage(for passenger: Passenger) {
        messages.append(.presentPassengerMessage(passenger: passenger))
    }
    
    func didNextStep(action: PassengerListAction) {
        messages.append(.didNextStep(action: action))
    }
}

final class PassengerListInteractorTest: XCTestCase {
    private lazy var serviceStub = PassengerListServiceStub()
    private lazy var presenterSpy = PassengerListPresenterSpy()
    private lazy var sut = PassengerListInteractor(presenter: presenterSpy, service: serviceStub)
}

// MARK: - Get passenger list tests
extension PassengerListInteractorTest {
    func testGetPassengerList_WhenSucceed_ShouldCallPresentPassengerList() {
        let passengerList: [Passenger] = .fixture()
        serviceStub.fetchPassengerListResult = .success(.fixture(passengerList: passengerList))
        
        sut.getPassengerList()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentPassengerList(passengerList: passengerList)
        ])
    }
    
    func testGetPassengerList_WhenFailed_ShouldCallPresentError() {
        let error: ApiError = .emptyData
        serviceStub.fetchPassengerListResult = .failure(error)
        
        sut.getPassengerList()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentErrorState(error: error)
        ])
    }
}

// MARK: - Get more passengers tests
extension PassengerListInteractorTest {
    func testGetMorePassengers_WhenSucceed_ShouldCallPresentPassengerList() {
        let passengerList: [Passenger] = .fixture()
        serviceStub.fetchPassengerListResult = .success(.fixture(passengerList: passengerList))
        
        sut.getPassengerList()
        sut.getMorePassengers()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentPassengerList(passengerList: passengerList),
            .presentFooterLoadingState,
            .presentPassengerList(passengerList: passengerList + passengerList)
        ])
    }
    
    func testGetMorePassengers_WhenFailed_ShouldCallPresentErrorState() {
        let error: ApiError = .emptyData
        let passengerList: [Passenger] = .fixture()
        serviceStub.fetchPassengerListResult = .success(.fixture(passengerList: passengerList))
        
        sut.getPassengerList()
        serviceStub.fetchPassengerListResult = .failure(error)
        sut.getMorePassengers()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentPassengerList(passengerList: passengerList),
            .presentFooterLoadingState,
            .presentErrorState(error: error)
        ])
    }
}

// MARK: - Retry tests
extension PassengerListInteractorTest {
    func testRetry_WhenSucceed_ShouldCallPresentPassengerList() {
        let passengerList: [Passenger] = .fixture()
        serviceStub.fetchPassengerListResult = .success(.fixture(passengerList: passengerList))
        
        sut.retry()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentPassengerList(passengerList: passengerList)
        ])
    }
    
    func testRetry_WhenFailed_ShouldCallPresentErrorState() {
        let error: ApiError = .emptyData
        serviceStub.fetchPassengerListResult = .failure(error)
        
        sut.retry()
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentErrorState(error: error)
        ])
    }
}

// MARK: - Show passenger message tests
extension PassengerListInteractorTest {
    func testShowPassengerMessage_WhenCalled_ShouldCallPresentPassengerMessage() {
        let index: Int = .zero
        let passengerList: [Passenger] = .fixture()
        serviceStub.fetchPassengerListResult = .success(.fixture(passengerList: passengerList))
        
        sut.getPassengerList()
        sut.showPasssengerMessage(at: index)
        
        XCTAssertEqual(presenterSpy.messages, [
            .presentLoadingState,
            .presentPassengerList(passengerList: passengerList),
            .presentPassengerMessage(passenger: passengerList[index])
        ])
    }
}
