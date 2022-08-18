import UIKit

final class PassengerListTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.medium
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.xSmall
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setup(with viewModel: PassengerViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.message
    }
}

private extension PassengerListTableViewCell {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupView()
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Space.base02),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.base03)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Space.base02),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.base03),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Space.base02)
        ])
    }
    
    func setupView() {
        selectionStyle = .none
    }
}
