import Foundation

final class Api<T: Decodable> {
    typealias Completion = (Result<T, ApiError>) -> Void
    
    private let endpoint: ApiEndpoint
    
    init(endpoint: ApiEndpoint) {
        self.endpoint = endpoint
    }
    
    func execute(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        _ completion: @escaping Completion
    ) {
        guard let url = URL(string: endpoint.urlString) else {
            completion(.failure(.badRequest))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            guard let json = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.self, from: json)
                completion(.success(decoded))
            }
            catch {
                completion(.failure(.decodeError(error)))
                return
            }
        }
        task.resume()
    }
}
