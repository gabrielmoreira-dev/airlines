import UIKit

final class ErrorView: UIView {
    private let tryAgain: () -> Void
    
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
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try Again", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(title: String, description: String, tryAgain: @escaping () -> Void) {
        self.tryAgain = tryAgain
        super.init(frame: .zero)
        titleLabel.text = title
        descriptionLabel.text = description
        tryAgainButton.addTarget(self, action: #selector(self.onTryAgainTapped), for: .touchUpInside)
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
        addSubview(tryAgainButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 196),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            tryAgainButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 32),
            tryAgainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tryAgainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tryAgainButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -72)
        ])
    }
    
    func setupView() {
        backgroundColor = .white
    }
}

@objc private extension ErrorView {
    func onTryAgainTapped() {
        tryAgain()
    }
}
