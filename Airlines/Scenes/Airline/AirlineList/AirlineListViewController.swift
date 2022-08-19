import UIKit

protocol AirlineListDisplaying: AnyObject {
    func displayAirlineList(_ airlines: [Airline])
    func displayLoadingState()
    func displayErrorState(_ model: ErrorViewModeling)
}

private extension AirlineListViewController.Layout {
    enum Size {
        static let tableRowHeight: CGFloat = Space.base09
    }
}

final class AirlineListViewController: StatefulViewController {
    private typealias Localizable = Strings.Airline.List
    fileprivate enum Layout { }
    
    private let interactor: AirlineListInteracting
    private var airlines: [Airline] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            AirlineListTableViewCell.self,
            forCellReuseIdentifier: String(describing: AirlineListTableViewCell.self)
        )
        tableView.rowHeight = Layout.Size.tableRowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        interactor.getAirlineList()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func setupView() {
        super.setupView()
        title = Localizable.title
    }
    
    override func didTapRetryButton() {
        interactor.retry()
    }
    
    init(interactor: AirlineListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension AirlineListViewController: AirlineListDisplaying {
    func displayAirlineList(_ airlines: [Airline]) {
        self.airlines = airlines
        tableView.reloadData()
        endLoadingState()
    }
    
    func displayLoadingState() {
        startLoadingState()
    }
    
    func displayErrorState(_ model: ErrorViewModeling) {
        endLoadingState(model)
    }
}

extension AirlineListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        airlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: AirlineListTableViewCell.self),
            for: indexPath
        ) as? AirlineListTableViewCell else { return UITableViewCell() }
        
        let item = airlines[indexPath.row]
        cell.setup(with: item)
        return cell
    }
}
