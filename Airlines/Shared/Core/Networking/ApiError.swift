enum ApiError: Error, Equatable {
    case network
    case badRequest
    case emptyData
    case serverError
    case decodeError
}
