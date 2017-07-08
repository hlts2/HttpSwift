
import Foundation


public extension URLRequest {
    
    public var verb: HttpMethod {
        set {
            httpMethod = newValue.rawValue
        }
        
        get {
            if let method = httpMethod {
                return HttpMethod(rawValue: method)!
            }
            
            return .UNKNOWN
        }
    }
    
    public func isURIParam() -> Bool {
        if let _ = httpMethod {
            if verb == .GET || verb == .DELETE || verb == .HEAD {
                return true
            }
        }
        
        return false
    }
    
    public mutating func appendParams(params: [String: String]) {
        
        var urlComponent = URLComponents(url: self.url!, resolvingAgainstBaseURL: true)!
        urlComponent.queryItems = params.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
        
        self.url = urlComponent.url
    }
    
    public mutating func appendParamsIntoBody(params: [String: String]) {
        var str = ""
        for(key, value) in params {
            str += key + "=" + value + "&"
        }
        
        self.httpBody = str.data(using: String.Encoding.utf8)
    }
    
}
