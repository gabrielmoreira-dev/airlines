enum ApiError: Error {
    case badRequest
    case emptyData
    case serverError(Error)
    case decodeError(Error)
}
