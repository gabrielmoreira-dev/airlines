import UIKit

class PassengerListViewScreen: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 50
        tableView.tableFooterView = spinnerView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var spinnerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        return view
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(delegate: UITableViewDataSource & UITableViewDelegate) {
        super.init(frame: .zero)
        tableView.dataSource = delegate
        tableView.delegate = delegate
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateSpinner(_ animate: Bool) {
        animate ? spinner.startAnimating() : spinner.stopAnimating()
    }
    
    func isLoading() -> Bool {
        spinner.isAnimating
    }
}

extension PassengerListViewScreen {
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(tableView)
        spinnerView.addSubview(spinner)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor)
        ])
    }
}
