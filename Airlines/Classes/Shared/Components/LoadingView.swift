import UIKit

final class LoadingView: UIView {
    private lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    func startLoadingState() {
        spinner.startAnimating()
    }
    
    func endLoadingState() {
        spinner.stopAnimating()
    }
}

private extension LoadingView {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupView()
    }
    
    func setupHierarchy() {
        addSubview(spinner)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupView() {
        backgroundColor = .white
    }
}
