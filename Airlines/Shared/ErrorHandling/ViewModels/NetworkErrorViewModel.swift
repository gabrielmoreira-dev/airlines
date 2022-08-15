struct NetworkErrorViewModel: ErrorViewModeling {
    private typealias Localizable = Strings.Error.Network
    
    var title: String { Localizable.title }
    var description: String { Localizable.description }
    
    init?(_ error: ApiError) {
        guard error == .network else { return nil }
    }
}
