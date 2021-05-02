import UIKit

class AirlineListViewScreen: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AirlineListTableViewCell.self, forCellReuseIdentifier: String(describing: AirlineListTableViewCell.self))
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
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
}

extension AirlineListViewScreen {
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
