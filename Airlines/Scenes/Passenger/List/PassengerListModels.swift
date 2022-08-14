import Foundation

enum PassengerList {

    enum GetPassengerList {
        struct Request {
            let page: Int
            let size: Int
        }
        struct Response {
            let passengers: [Passenger]
            let nextPage: Int
            let size: Int
        }
        struct ViewModel {
            let passengers: [Passenger]
            let nextPage: Int
            let size: Int
        }
    }
    
    enum ShowMessage {
        struct Request {
            let index: Int
        }
        struct Response {
            let passenger: Passenger
        }
        struct ViewModel {
            let title: String
            let message: String
        }
    }
    
    struct PassengerData: Decodable {
        let data: [Passenger]
        let totalPages: Int
    }
    
    struct Passenger: Decodable {
        let name: String?
        let trips: Int?
    }
}
