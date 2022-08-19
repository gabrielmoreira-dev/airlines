@testable import Airlines

extension PassengerPayload {
    static func fixture(passengerList: [Passenger] = .fixture(), next: Int = 1) -> Self {
        .init(passengerList: passengerList, next: next)
    }
}
