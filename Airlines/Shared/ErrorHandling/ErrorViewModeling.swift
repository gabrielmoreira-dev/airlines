protocol ErrorViewModeling {
    var title: String { get }
    var description: String { get }
    
    init?(_ error: ApiError)
}
