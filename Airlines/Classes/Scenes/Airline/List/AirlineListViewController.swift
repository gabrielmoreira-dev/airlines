import UIKit

protocol AirlineListDisplayLogic: class {
    func displayAirlineList(viewModel: AirlineList.GetAirlineList.ViewModel)
}

class AirlineListViewController: UIViewController {
    private var interactor: AirlineListBusinessLogic?
    private var router: (NSObjectProtocol & AirlineListRoutingLogic & AirlineListDataPassing)?
    private var viewModel: AirlineList.GetAirlineList.ViewModel?
    private var viewScreen: AirlineListViewScreen?
    
    func configureInterctor(_ interactor: AirlineListBusinessLogic) {
        self.interactor = interactor
    }
    
    func configureRouter(_ router: NSObjectProtocol & AirlineListRoutingLogic & AirlineListDataPassing) {
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let request = AirlineList.GetAirlineList.Request()
        interactor?.fetchAirlineList(request: request)
    }
}

extension AirlineListViewController: AirlineListDisplayLogic {
    func displayAirlineList(viewModel: AirlineList.GetAirlineList.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.viewModel = viewModel
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
        viewModel?.airlines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableView = viewScreen?.tableView else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AirlineListTableViewCell.self), for: indexPath) as? AirlineListTableViewCell else {
            return UITableViewCell()
        }
        guard let item = viewModel?.airlines[indexPath.row] else {
            return cell
        }
        cell.setViewModel(item)
        return cell
    }
}
