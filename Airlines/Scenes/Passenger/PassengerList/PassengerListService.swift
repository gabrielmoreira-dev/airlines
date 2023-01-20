import Foundation

protocol PassengerListServicing {
    func fetchPassengerList(page: Int, completion: @escaping PassengerListCompletion)
}

typealias PassengerListCompletion = (Result<PassengerPayload, ApiError>) -> Void

final class PassengerListService {
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

extension PassengerListService: PassengerListServicing {
    func fetchPassengerList(page: Int, completion: @escaping PassengerListCompletion) {
        let endpoint = PassengerEndpoint.passengerList(page: page)
        let api = Api<PassengerPayload>(endpoint: endpoint)
        api.execute(session: dependencies.session, decoder: decoder) { [weak self] result in
            self?.dependencies.mainQueue.async { completion(result) }
        }
    }
}
