enum PassengerEndpoint: ApiEndpoint {
    case passengerList(next: Int)
    
    var path: String {
        switch self {
        case let .passengerList(next):
            return "passengers?next=\(next)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .passengerList:
            return .get
        }
    }
}
