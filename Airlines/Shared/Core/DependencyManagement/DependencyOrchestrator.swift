final class DependencyOrchestrator {
    static let shared = DependencyOrchestrator()
    private var bag: [String: (type: Any.Type, resolver: () -> Any)] = [:]
    
    private init() {}
    
    func safelyResolve<Dependency>() -> Dependency? {
        bag[String(reflecting: Dependency.self)]?.resolver() as? Dependency
    }
    
    func resolve<Dependency>() -> Dependency {
        guard let dependency: Dependency = safelyResolve() else {
            fatalError("Could not resolve dependency \(Dependency.self)")
        }
        return dependency
    }
    
    static func whenFindProtocol<Dependency>(_ type: Dependency.Type, returns: @escaping () -> Dependency) {
        if let _: Dependency = shared.safelyResolve() {
            fatalError("Dependency \(String(reflecting: type)) is already registered")
        }
        shared.bag[String(reflecting: type)] = (type, returns)
    }
}
