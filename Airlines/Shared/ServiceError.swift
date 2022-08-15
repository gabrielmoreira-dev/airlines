import Foundation

enum ServiceError: Error {
    case request, server, emptyData, parser
}
