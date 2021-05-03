import UIKit

protocol PassengerListDisplayLogic: class {
    func displayPassengerList(viewModel: PassengerList.GetPassengerList.ViewModel)
}

class PassengerListViewController: UIViewController {
    private var interactor: PassengerListBusinessLogic?
    private var router: (NSObjectProtocol & PassengerListRoutingLogic & PassengerListDataPassing)?
    private var viewModel: PassengerList.GetPassengerList.ViewModel?
    private var viewScreen: PassengerListViewScreen?
    
    func configureInterctor(_ interactor: PassengerListBusinessLogic) {
        self.interactor = interactor
    }
    
    func configureRouter(_ router: NSObjectProtocol & PassengerListRoutingLogic & PassengerListDataPassing) {
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.viewScreen = PassengerListViewScreen(delegate: self)
        self.setupViewScreen()
        fetchPassengerList(page: 0, size: 20)
    }
    
    private func fetchPassengerList(page: Int, size: Int) {
        let request = PassengerList.GetPassengerList.Request(page: page, size: size)
        interactor?.fetchPassengerList(request: request)
    }
}

extension PassengerListViewController: PassengerListDisplayLogic {
    func displayPassengerList(viewModel: PassengerList.GetPassengerList.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.viewScreen?.animateSpinner(false)
            self.viewModel = viewModel
            self.viewScreen?.tableView.reloadData()
        }
    }
}

extension PassengerListViewController {
    private func setupView() {
        title = "Passengers"
        view.backgroundColor = .white
    }
    
    private func setupViewScreen() {
        guard let _ = viewScreen else { return }
        setupHierarchy()
        setupConstraints()
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

extension PassengerListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.passengers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableView = viewScreen?.tableView else {
            return UITableViewCell()
        }
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        
        if (cell == nil) {
            cell = UITableViewCell(style: .value1,
                        reuseIdentifier: String(describing: UITableViewCell.self))
        }
        
        guard let item = viewModel?.passengers[indexPath.row] else {
            return cell ?? UITableViewCell()
        }
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = "\(item.trips ?? 0) trips"
        return cell ?? UITableViewCell()
    }
}

extension PassengerListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard
            let viewScreen = viewScreen,
            let viewModel = viewModel
        else { return }
        
        let position = scrollView.contentOffset.y
        let expectedPosition = viewScreen.tableView.contentSize.height - scrollView.frame.size.height
        if position > expectedPosition {
            if(!viewScreen.isLoading()) {
                viewScreen.animateSpinner(true)
                fetchPassengerList(page: viewModel.nextPage, size: viewModel.size)
            }
        }
    }
}
