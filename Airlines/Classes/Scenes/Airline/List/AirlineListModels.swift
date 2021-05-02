import Foundation

enum AirlineList {

    enum GetAirlineList {
        struct Request {
        }
        struct Response {
            let airlines: [Airline]
        }
        struct ViewModel {
            let airlines: [Airline]
        }
    }
    
    struct Airline: Decodable {
        let name: String?
        let logo: String?
        let slogan: String?
    }
}
