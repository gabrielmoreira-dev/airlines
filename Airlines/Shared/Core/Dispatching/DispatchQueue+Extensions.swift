import Foundation

extension DispatchQueue: MainQueueDispatching {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, execute: work)
    }
}
