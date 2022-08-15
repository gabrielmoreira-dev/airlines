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

final class AirlineListViewController: UIViewController {
    fileprivate enum Layout { }
    private typealias Localizable = Strings.Airline.List
    
    private var airlines: [Airline] = []
    private let interactor: AirlineListInteracting
    
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
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.retryAction = { [weak self] in self?.interactor.fetchAirlineList() }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        interactor.fetchAirlineList()
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
        loadingView.endLoadingState()
        loadingView.isHidden = true
    }
    
    func displayLoadingState() {
        errorView.isHidden = true
        loadingView.isHidden = false
        loadingView.startLoadingState()
    }
    
    func displayErrorState(_ model: ErrorViewModeling) {
        errorView.setup(with: model)
        errorView.isHidden = false
        loadingView.endLoadingState()
    }
}

private extension AirlineListViewController {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupView()
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupView() {
        title = Localizable.title
        view.backgroundColor = .white
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
