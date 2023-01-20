import Foundation

final class DependencyContainer: HasMainQueue, HasSession {
    private let orchestrator: DependencyOrchestrator
    
    lazy var mainQueue: MainQueueDispatching = orchestrator.resolve()
    lazy var session: URLSession = orchestrator.resolve()
    
    init(orchestrator: DependencyOrchestrator = .shared) {
        self.orchestrator = orchestrator
    }
}
