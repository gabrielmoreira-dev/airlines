import Foundation

class AirlineListWorker {
    func fetchAirlineList(completion: @escaping (Result<[AirlineList.Airline], ServiceError>) -> Void) {
        let baseUrl = "https://api.instantwebtools.net/v1/airlines"
        
        guard let url = URL(string: baseUrl) else {
            completion(.failure(.request))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.server))
                return
            }
            
            guard let json = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([AirlineList.Airline].self, from: json)
                completion(.success(decoded))
            }
            catch {
                completion(.failure(.parser))
                return
            }
        }
        task.resume()
    }
}
