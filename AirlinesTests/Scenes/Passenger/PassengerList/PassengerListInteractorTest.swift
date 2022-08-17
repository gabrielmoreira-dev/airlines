@testable import Airlines
import XCTest

private final class PassengerListServiceStub: RefactoryPassengerListServicing {
    
}

private final class PassengerListPresenterSpy: RefactoryPassengerListPresenting {
    enum Message: Equatable {
    }
    
    private(set) var messages: [Message] = []
}

final class PassengerListInteractorTest: XCTestCase {
    private lazy var serviceStub = PassengerListServiceStub()
    private lazy var presenterSpy = PassengerListPresenterSpy()
    private lazy var sut = RefactoryPassengerListInteractor(presenter: presenterSpy, service: serviceStub)
}

extension PassengerListInteractorTest {
    
}
