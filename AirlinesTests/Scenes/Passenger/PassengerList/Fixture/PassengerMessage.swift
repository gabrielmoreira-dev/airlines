@testable import Airlines

extension PassengerMessage {
    static func fixture(passenger: Passenger = .fixture()) -> Self {
        .init(
            title: passenger.name,
            description: Strings.Passenger.List.Message.description(passenger.trips)
        )
    }
}
