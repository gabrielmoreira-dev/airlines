final class ErrorViewModelResolver {
    private static var viewModels: [ErrorViewModeling.Type] {
        [
            GenericErrorViewModel.self,
            NetworkErrorViewModel.self
        ]
    }
    
    static func resolve(from error: ApiError) -> ErrorViewModeling {
        viewModels.lazy.compactMap { $0.init(error) } .first ?? GenericErrorViewModel()
    }
}
