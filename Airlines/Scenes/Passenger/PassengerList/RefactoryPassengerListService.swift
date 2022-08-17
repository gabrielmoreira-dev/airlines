import Foundation

protocol RefactoryPassengerListServicing {
    func fetchPassengerList(next: Int, completion: @escaping PassengerListCompletion)
}

typealias PassengerListCompletion = (Result<PassengerPayload, ApiError>) -> Void

final class RefactoryPassengerListService {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension RefactoryPassengerListService: RefactoryPassengerListServicing {
    func fetchPassengerList(next: Int, completion: @escaping PassengerListCompletion) {
        let endpoint = PassengerEndpoint.passengerList(next: next)
        let api = Api<PassengerPayload>(endpoint: endpoint)
        api.execute(decoder: decoder) { result in
            DispatchQueue.main.async { completion(result) }
        }
    }
}
