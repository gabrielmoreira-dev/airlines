import UIKit

protocol StatefulViewing {
    func didTapRetryButton()
}

class StatefulViewController: UIViewController, StatefulViewing {
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.retryAction = { [weak self] in self?.didTapRetryButton() }
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func didTapRetryButton() { }
    
    func setupHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
}

extension StatefulViewController {
    func setupLayout() {
        setupHierarchy()
        setupConstraints()
        setupView()
    }
    
    func startLoadingState() {
        loadingView.startLoadingState()
        loadingView.isHidden = false
        errorView.isHidden = true
        view.bringSubviewToFront(loadingView)
    }
    
    func endLoadingState() {
        loadingView.endLoadingState()
        loadingView.isHidden = true
        errorView.isHidden = true
    }
    
    func endLoadingState(_ model: ErrorViewModeling) {
        errorView.setup(with: model)
        loadingView.endLoadingState()
        loadingView.isHidden = true
        errorView.isHidden = false
        view.bringSubviewToFront(errorView)
    }
}
