import UIKit

protocol RefactoryPassengerListDisplaying: AnyObject {
    
}

final class RefactoryPassengerListViewController: UIViewController {
    private let interactor: RefactoryPassengerListInteracting
    
    init(interactor: RefactoryPassengerListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension RefactoryPassengerListViewController: RefactoryPassengerListDisplaying {
    
}
