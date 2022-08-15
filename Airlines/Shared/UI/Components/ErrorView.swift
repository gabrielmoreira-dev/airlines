import UIKit

final class ErrorView: UIView {
    private typealias Localizable = Strings.Error
    
    var retryAction: (() -> Void)? = nil
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.xLarge
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.medium
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localizable.RetryButton.title, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        retryButton.addTarget(self, action: #selector(self.onRetryButtonTapped), for: .touchUpInside)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setup(with model: ErrorViewModeling) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}

private extension ErrorView {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupView()
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(retryButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Space.base10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.base03)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Space.base06),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.base03)
        ])
        
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: Space.base05),
            retryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03),
            retryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.base03),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Space.base07)
        ])
    }
    
    func setupView() {
        backgroundColor = .white
    }
}

@objc private extension ErrorView {
    func onRetryButtonTapped() {
        retryAction?()
    }
}
