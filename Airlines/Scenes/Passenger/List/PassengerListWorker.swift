import Foundation

class PassengerListWorker {
    func fetchPassengerList(request: PassengerList.GetPassengerList.Request, completion: @escaping (Result<PassengerList.PassengerData, ServiceError>) -> Void) {
        let baseUrl = "https://api.instantwebtools.net/v1/passenger?page=\(request.page)&size=\(request.size)"
        
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
                let decoded = try decoder.decode(PassengerList.PassengerData.self, from: json)
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
