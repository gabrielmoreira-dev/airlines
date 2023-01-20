final class DependencyContainer: HasMainQueue {
    private let orchestrator: DependencyOrchestrator
    
    lazy var mainQueue: MainQueueDispatching = orchestrator.resolve()
    
    init(orchestrator: DependencyOrchestrator = .shared) {
        self.orchestrator = orchestrator
    }
}
