import UIKit

protocol RefactoryPassengerListDisplaying: AnyObject {
    func displayAirlineList()
    func displayLoadingState()
    func displayErrorState(_ model: ErrorViewModeling)
}

final class RefactoryPassengerListViewController: StatefulViewController {
    private typealias Localizable = Strings.Passenger.List
    
    private let interactor: RefactoryPassengerListInteracting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        interactor.getPassengerList()
    }
    
    override func didTapRetryButton() {
        interactor.getPassengerList()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
    
    override func setupView() {
        super.setupView()
        title = Localizable.title
    }
    
    init(interactor: RefactoryPassengerListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension RefactoryPassengerListViewController: RefactoryPassengerListDisplaying {
    func displayAirlineList() {
        
    }
    
    func displayLoadingState() {
        startLoadingState()
    }
    
    func displayErrorState(_ model: ErrorViewModeling) {
        endLoadingState(model)
    }
}
