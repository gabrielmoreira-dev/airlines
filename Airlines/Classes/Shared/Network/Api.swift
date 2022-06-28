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
        
        makeRequest(url: url, session: session, decoder: decoder) { result in
            switch result {
            case let .success(data):
                self.decode(data: data, completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

private extension Api {
    func makeRequest(
        url: URL,
        session: URLSession,
        decoder: JSONDecoder,
        _ completion: @escaping (Result<Data, ApiError>) -> Void
    ) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            guard let json = data else {
                completion(.failure(.emptyData))
                return
            }
            
            completion(.success(json))
        }
        task.resume()
    }
    
    func decode(data: Data, _ completion: @escaping Completion) {
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(.decodeError(error)))
        }
    }
}
