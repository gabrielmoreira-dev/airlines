import Foundation

final class DependencyInjection {
    static func registerDependencies() {
        DependencyOrchestrator
            .whenFindProtocol(MainQueueDispatching.self, returns: { DispatchQueue.main })
    }
}
