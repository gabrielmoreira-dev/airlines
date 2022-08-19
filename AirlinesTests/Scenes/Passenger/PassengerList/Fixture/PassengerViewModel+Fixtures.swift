@testable import Airlines

extension Array where Element == PassengerViewModel {
    static func fixture(passengerList: [Passenger] = .fixture()) -> Self {
        passengerList.map {
            PassengerViewModel(
                title: $0.name,
                message: Strings.Passenger.List.Item.description($0.trips)
            )
        }
    }
}
