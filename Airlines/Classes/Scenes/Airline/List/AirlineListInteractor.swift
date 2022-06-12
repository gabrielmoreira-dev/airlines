import Foundation

protocol AirlineListInteracting {
    func fetchAirlineList()
}

final class AirlineListInteractor {
    private let presenter: AirlineListPresenting
    private let service: AirlineListServicing
    
    init(presenter: AirlineListPresenting, service: AirlineListServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension AirlineListInteractor: AirlineListInteracting {
    func fetchAirlineList() {
        service.fetchAirlineList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let airlines):
                    self.presenter.presentAirlineList(airlines)
                case .failure(let error):
                    print(error)
                    break
            }
        }
    }
}
