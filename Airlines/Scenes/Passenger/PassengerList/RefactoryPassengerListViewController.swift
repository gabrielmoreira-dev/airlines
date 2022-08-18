import UIKit

protocol RefactoryPassengerListDisplaying: AnyObject {
    func displayPassengerList(_ passengers: [PassengerViewModel])
    func displayFooterLoadingState()
    func displayLoadingState()
    func displayErrorState(_ model: ErrorViewModeling)
}

private extension RefactoryPassengerListViewController.Layout {
    enum Size {
        static let spinnerViewHeight: CGFloat = Space.base09
    }
}

final class RefactoryPassengerListViewController: StatefulViewController {
    private typealias Localizable = Strings.Passenger.List
    fileprivate enum Layout { }
    
    private let interactor: RefactoryPassengerListInteracting
    private var passengers: [PassengerViewModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            PassengerListTableViewCell.self,
            forCellReuseIdentifier: String(describing: PassengerListTableViewCell.self)
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = spinnerView
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var spinnerView: UIView = {
        let spinnerView = UIView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: Layout.Size.spinnerViewHeight)
        )
        return spinnerView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        interactor.getPassengerList()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        view.addSubview(tableView)
        spinnerView.addSubview(spinner)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor)
        ])
    }
    
    override func setupView() {
        super.setupView()
        title = Localizable.title
    }
    
    override func didTapRetryButton() {
        interactor.retry()
    }
    
    init(interactor: RefactoryPassengerListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension RefactoryPassengerListViewController: RefactoryPassengerListDisplaying {
    func displayPassengerList(_ passengers: [PassengerViewModel]) {
        self.passengers = passengers
        tableView.reloadData()
        endLoadingState()
        spinner.stopAnimating()
    }
    
    func displayFooterLoadingState() {
        spinner.startAnimating()
    }
    
    func displayLoadingState() {
        startLoadingState()
    }
    
    func displayErrorState(_ model: ErrorViewModeling) {
        endLoadingState(model)
    }
}

extension RefactoryPassengerListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        passengers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: PassengerListTableViewCell.self),
            for: indexPath
        ) as? PassengerListTableViewCell else { return UITableViewCell() }
        
        let item = passengers[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor.showPasssengerMessage(at: indexPath.row)
    }
}

extension RefactoryPassengerListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let expectedPosition = tableView.contentSize.height - scrollView.frame.size.height
        if position > expectedPosition {
            interactor.getMorePassengers()
        }
    }
}
