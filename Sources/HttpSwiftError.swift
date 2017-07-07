import Foundation

public enum HttpSwiftError: Error {
    case connectionError(Error)
    case responseError
    case statusCodeNotSuccess
}
