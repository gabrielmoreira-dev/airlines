import UIKit

final class ErrorView: UIView {
    private typealias Localizable = Strings.Error
    
    private let retry: () -> Void
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18.0)
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
    
    init(title: String, description: String, retry: @escaping () -> Void) {
        self.retry = retry
        super.init(frame: .zero)
        titleLabel.text = title
        descriptionLabel.text = description
        retryButton.addTarget(self, action: #selector(self.onRetryButtonTapped), for: .touchUpInside)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
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
        retry()
    }
}
