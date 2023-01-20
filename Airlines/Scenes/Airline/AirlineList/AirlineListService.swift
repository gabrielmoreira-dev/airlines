import Foundation

protocol AirlineListServicing {
    func fetchAirlineList(completion: @escaping AirlineListCompletion)
}

typealias AirlineListCompletion = (Result<[Airline], ApiError>) -> Void

final class AirlineListService {
    typealias Dependencies = HasSession & HasMainQueue
    private let dependencies: Dependencies
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension AirlineListService: AirlineListServicing {
    func fetchAirlineList(completion: @escaping AirlineListCompletion) {
        let endpoint = AirlineEndpoint.airlineList
        let api = Api<[Airline]>(endpoint: endpoint)
        api.execute(session: dependencies.session, decoder: decoder) { [weak self] result in
            self?.dependencies.mainQueue.async { completion(result) }
        }
    }
}
