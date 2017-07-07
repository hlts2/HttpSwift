import Foundation

public enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(value: Error) {
        self = .failure(value)
    }
}