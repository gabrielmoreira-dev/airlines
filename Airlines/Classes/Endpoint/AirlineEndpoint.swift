enum AirlineEndpoint: ApiEndpoint {
    case airlineList
    
    var path: String {
        switch self {
        case .airlineList:
            return "airlines"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .airlineList:
            return .get
        }
    }
}
