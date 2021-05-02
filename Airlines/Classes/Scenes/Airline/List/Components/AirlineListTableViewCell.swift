import UIKit

class AirlineListTableViewCell: UITableViewCell {
    private var viewModel: AirlineList.Airline?
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ viewModel: AirlineList.Airline) {
        self.viewModel = viewModel
        additionalSetup()
    }
}

extension AirlineListTableViewCell {
    func setupView() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(verticalStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    func additionalSetup() {
        guard
            let title = self.viewModel?.name,
            let subtitle = self.viewModel?.slogan,
            let imageURL = self.viewModel?.logo
            else { return }
        
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }
}
