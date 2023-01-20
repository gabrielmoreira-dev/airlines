protocol MainQueueDispatching {
    func async(execute work: @escaping @convention(block) () -> Void)
}

protocol HasMainQueue {
    var mainQueue: MainQueueDispatching { get }
}
