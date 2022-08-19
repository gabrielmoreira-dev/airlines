enum PassengerEndpoint: ApiEndpoint {
    case passengerList(page: Int)
    
    var path: String {
        switch self {
        case let .passengerList(page):
            return "passengers?page=\(page)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .passengerList:
            return .get
        }
    }
}
