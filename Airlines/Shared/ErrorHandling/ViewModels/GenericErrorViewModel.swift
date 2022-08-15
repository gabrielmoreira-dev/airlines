struct GenericErrorViewModel: ErrorViewModeling {
    private typealias Localizable = Strings.Error.Generic
    
    var title: String { Localizable.title }
    var description: String { Localizable.description }
    
    init?(_ error: ApiError) {
        guard error == .badRequest || error == .decodeError || error == .emptyData || error == .serverError
        else { return nil }
    }
    
    init() { }
}
