import UIKit

protocol StatefulViewing {
    func didTapRetryButton()
}

extension StatefulViewing where Self: UIViewController {
    func setupStatefulViewLayout() {
        setupStatefulViewHierarchy()
        setupStatefulViewConstraints()
    }
    
    func startLoadingState() {
        loadingView.startLoadingState()
        loadingView.isHidden = false
        errorView.isHidden = true
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
    }
}

private extension StatefulViewing where Self: UIViewController {
    var loadingView: LoadingView { StatefulViewFactory.makeLoadingView() }
    
    var errorView: ErrorView {
        StatefulViewFactory.makeErrorView(with: { [weak self] in
            self?.didTapRetryButton()
        })
    }
    
    func setupStatefulViewHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }
    
    func setupStatefulViewConstraints() {
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
}

private class StatefulViewFactory {
    private static var loadingView: LoadingView = {
        let view = LoadingView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private static var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static func makeLoadingView() -> LoadingView { loadingView }
    
    static func makeErrorView(with retryAction: @escaping () -> Void) -> ErrorView {
        errorView.with(retryAction)
    }
}
