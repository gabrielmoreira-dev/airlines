import Foundation

protocol AirlineListServicing {
    func fetchAirlineList(completion: @escaping AirlineListCompletion)
}

typealias AirlineListCompletion = (Result<[Airline], ApiError>) -> Void

final class AirlineListService {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension AirlineListService: AirlineListServicing {
    func fetchAirlineList(completion: @escaping AirlineListCompletion) {
        let endpoint = AirlineEndpoint.airlineList
        let api = Api<[Airline]>(endpoint: endpoint)
        api.execute(decoder: decoder) { result in
            DispatchQueue.main.async { completion(result) }
        }
    }
}
