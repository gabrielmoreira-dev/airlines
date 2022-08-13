import UIKit

protocol AirlineListDisplaying: AnyObject {
    func displayAirlineList(_ airlines: [Airline])
    func displayLoadingState()
    func displayEndLoadingState()
}

private extension AirlineListViewController.Layout {
    enum Size {
        static let tableRowHeight: CGFloat = 100
    }
}

final class AirlineListViewController: UIViewController {
    fileprivate enum Layout { }
    private var airlines: [Airline] = []
    private let interactor: AirlineListInteracting
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AirlineListTableViewCell.self, forCellReuseIdentifier: String(describing: AirlineListTableViewCell.self))
        tableView.rowHeight = Layout.Size.tableRowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var loadingView = LoadingView()
    
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
    }
    
    func displayLoadingState() {
        loadingView.startLoadingState()
    }
    
    func displayEndLoadingState() {
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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupView() {
        title = "Airlines"
        view.backgroundColor = .white
    }
}

extension AirlineListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        airlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AirlineListTableViewCell.self), for: indexPath) as? AirlineListTableViewCell else {
            return UITableViewCell()
        }
        let item = airlines[indexPath.row]
        cell.setup(with: item)
        return cell
    }
}
