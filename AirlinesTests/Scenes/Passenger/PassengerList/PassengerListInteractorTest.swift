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
        case presentPassengerList(passengers: [Passenger])
        case presenterFooterLoadingState
        case presentLoadingState
        case presentErrorState(error: ApiError)
        case presentPassengerMessage(passenger: Passenger)
        case didNextStep(action: PassengerListAction)
    }
    
    private(set) var messages: [Message] = []
    
    func presentPassengerList(_ passengers: [Passenger]) {
        messages.append(.presentPassengerList(passengers: passengers))
    }
    
    func presentFooterLoadingState() {
        messages.append(.presenterFooterLoadingState)
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

extension PassengerListInteractorTest {
    
}
