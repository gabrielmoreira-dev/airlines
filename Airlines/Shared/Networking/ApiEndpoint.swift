import Foundation

enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
}

protocol ApiEndpoint {
    var baseUrl: URL { get }
    var path: String { get }
    var urlString: String { get }
    var method: HTTPMethod { get }
}

extension ApiEndpoint {
    var baseUrl: URL {
        let urlString = "http://localhost:8080"
        guard let url = URL(string: urlString) else {
            fatalError("Undefined base URL")
        }
        return url
    }
    
    var urlString: String {
        "\(baseUrl.absoluteURL)/\(path)"
    }
    
    var method: HTTPMethod { .get }
}
