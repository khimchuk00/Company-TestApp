import Foundation

@propertyWrapper
class OptionalBindingValue<T> {
    
    typealias CompletionHandler = ((T?) -> Void)
    typealias NonNilCompletionHandler = ((T) -> Void)
    
    private var observers = [() -> Void]()
    
    var wrappedValue : T? {
        didSet {
            self.notify()
        }
    }
    
    var projectedValue: OptionalBindingValue<T> { return self }
    
    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    @discardableResult
    func observeNonNil(on queue: DispatchQueue = .main, completionHandler: @escaping NonNilCompletionHandler) -> OptionalBindingValue<T> {
        
        let modifiedBlock = {
            if let value = self.wrappedValue {
                queue.async {
                    completionHandler(value)
                }
            }
        }
        
        modifiedBlock()
        observers.append(modifiedBlock)
        
        return projectedValue
    }
    
    @discardableResult
    func observe(on queue: DispatchQueue = .main, completionHandler: @escaping CompletionHandler) -> OptionalBindingValue<T> {
        
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
