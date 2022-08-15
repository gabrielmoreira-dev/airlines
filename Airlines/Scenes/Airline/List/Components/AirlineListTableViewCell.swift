import UIKit

final class AirlineListTableViewCell: UITableViewCell {
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.large
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.xSmall
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setup(with viewModel: Airline) {
        titleLabel.text = viewModel.name
        subtitleLabel.text = viewModel.slogan
        logoImageView.load(from: viewModel.logoUrl)
    }
}

private extension AirlineListTableViewCell {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: Space.base04),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Space.base04)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Space.base04),
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Space.base04),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Space.base03)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Space.base04),
            subtitleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Space.base04),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Space.base03),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Space.base04)
        ])
    }
}
