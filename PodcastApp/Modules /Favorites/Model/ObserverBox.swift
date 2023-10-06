import Foundation

class ObserverBox<T> {

    //MARK: - Properties
    
    typealias Listener = (T) -> Void

    var listener: Listener?

    var value: T {
        didSet {
            DispatchQueue.main.async { self.listener?(self.value) }
        }
    }

    //MARK: - Init
    
    init(value: T) {
        self.value = value
    }

    //MARK: - Bind
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
