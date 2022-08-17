@testable import Airlines

extension Airline {
    static func fixture(
        name: String = "A name",
        logoUrl: String = "https://logos.com/resource",
        slogan: String = "A slogan"
    ) -> Self {
        .init(name: name, logoUrl: logoUrl, slogan: slogan)
    }
}

extension Array where Element == Airline {
    static func fixture() -> Self {
        [.fixture(), .fixture(), .fixture()]
    }
}
