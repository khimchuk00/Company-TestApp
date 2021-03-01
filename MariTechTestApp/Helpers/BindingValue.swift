import Foundation

@propertyWrapper
class BindingValue<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    private var observers = [() -> Void]()
    
    var wrappedValue : T {
        didSet {
            self.notify()
        }
    }
    
    var projectedValue: BindingValue<T> { return self }
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    @discardableResult
    func observe(on queue: DispatchQueue = .main, completionHandler: @escaping CompletionHandler) -> BindingValue<T> {
        
        let modifiedBlock = {
            queue.async {
                completionHandler(self.wrappedValue)
            }
        }
        
        modifiedBlock()
        observers.append(modifiedBlock)
        
        return projectedValue
    }
    
    func notify() {
        observers.forEach { $0() }
    }
    
    deinit {
        observers.removeAll()
    }
}
