import UIKit

protocol AirlineListDisplaying: AnyObject {
    func displayAirlineList(_ airlines: [Airline])
}

final class AirlineListViewController: UIViewController {
    private var viewScreen: AirlineListViewScreen?
    private var airlines: [Airline] = []
    private let interactor: AirlineListInteracting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.airlines = airlines
            self.viewScreen = AirlineListViewScreen(delegate: self)
            self.setupViewScreen()
        }
    }
}

extension AirlineListViewController {
    private func setupView() {
        title = "Airlines"
        view.backgroundColor = .white
    }
    
    private func setupViewScreen() {
        guard let viewScreen = viewScreen else { return }
        setupHierarchy()
        setupConstraints()
        viewScreen.tableView.reloadData()
    }
    
    private func setupHierarchy() {
        guard let viewScreen = viewScreen else { return }
        view.addSubview(viewScreen)
    }
    
    private func setupConstraints() {
        guard let viewScreen = viewScreen else { return }
        NSLayoutConstraint.activate([
            viewScreen.topAnchor.constraint(equalTo: view.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension AirlineListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        airlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableView = viewScreen?.tableView else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AirlineListTableViewCell.self), for: indexPath) as? AirlineListTableViewCell else {
            return UITableViewCell()
        }
        let item = airlines[indexPath.row]
        cell.setViewModel(item)
        return cell
    }
}
