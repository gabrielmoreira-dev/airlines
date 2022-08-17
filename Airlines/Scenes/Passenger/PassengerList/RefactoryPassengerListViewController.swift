import UIKit

protocol RefactoryPassengerListDisplaying: AnyObject {
    func displayAirlineList()
}

final class RefactoryPassengerListViewController: UIViewController {
    private typealias Localizable = Strings.Passenger.List
    
    private let interactor: RefactoryPassengerListInteracting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        interactor.getPassengerList()
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
}

private extension RefactoryPassengerListViewController {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupView()
    }
    
    func setupHierarchy() {
    }
    
    func setupConstraints() {
    }
    
    func setupView() {
        title = Localizable.title
        view.backgroundColor = .white
        setupStatefulViewLayout()
    }
}

extension RefactoryPassengerListViewController: StatefulViewing {
    func didTapRetryButton() {
        interactor.getPassengerList()
    }
}
