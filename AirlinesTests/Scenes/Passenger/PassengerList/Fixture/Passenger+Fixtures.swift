@testable import Airlines

extension Passenger {
    static func fixture(name: String = "A name", trips: Int = 0) -> Self {
        .init(name: name, trips: trips)
    }
}

extension Array where Element == Passenger {
    static func fixture() -> Self {
        [.fixture(), .fixture(), .fixture()]
    }
}
