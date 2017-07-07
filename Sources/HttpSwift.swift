import Foundation

public enum HttpMethod {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
    case HEAD
    
    public func description() -> String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        case .DELETE:
            return "DELETE"
        case .PATCH:
            return "PATCH"
        case .HEAD:
            return "HEAD"
        }
    }
}

open class HTTP {
    
    open let session: URLSession = {
        let conf = URLSessionConfiguration.default
        return URLSession(configuration: conf)
    }()
    
    private var request = Request()
    
    private init() {}
    public static let instance: HTTP = {
        return HTTP()
    }()
    
    //Setting Content-type Header
    open func setContentsType(_ type: ContentsType) -> HTTP {
        request.contentsType = type
        return self
    }
    
    //Setting Request Parameter
    open func setQuery(params: [String: String]) -> HTTP {
        self.request.params = params
        return self
    }
    
    open func get(url: String) -> HTTP {
        self.request.url = url
        self.request.method = HttpMethod.GET
        return self
    }
    
    open class func Get(url: String) -> HTTP {
        return HTTP().get(url: url)
    }
    
    open func post(url: String) -> HTTP {
        self.request.url = url
        self.request.method = HttpMethod.POST
        return self
    }
    
    open class func Post(url: String) -> HTTP {
        return HTTP().post(url: url)
    }
    
    open func put(url: String) -> HTTP {
        self.request.url = url
        self.request.method = HttpMethod.PUT
        return self
    }
    
    open class func Put(url: String) -> HTTP {
        return HTTP().put(url: url)
    }
    
    open func patch(url: String) -> HTTP {
        self.request.url = url
        self.request.method = HttpMethod.PATCH
        return self
    }
    
    open class func Patch(url: String) -> HTTP {
        return HTTP().patch(url: url)
    }
    
    open func delete(url: String) -> HTTP {
        self.request.url = url
        self.request.method = HttpMethod.DELETE
        return self
    }
    
    open class func Delete(url: String) -> HTTP {
        return HTTP().delete(url: url)
    }
    
    
    //Execute Request
    open func `do`(handler: @escaping (_ strData: Any) -> ()) {
        guard let _ = request.url else {
            return
        }
        
        session.dataTask(with: request.createRequest()) { data, response, error in
            
            do {
                
                switch(data, response, error) {
                case(_, _, let error?):
                    throw HttpSwiftError.connectionError(error)
                    
                case(let data?, let resp, _):
                    
                    //Check Status Code
                    if 200..<300 ~= (resp as! HTTPURLResponse).statusCode {
                        
                        //Check Contents Type
                        switch self.request.contentsType {
                        case ContentsType.json?:
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            
                            handler(json)
                        default:
                            
                            if let str = String(data: data, encoding: .utf8) {
                                handler(str)
                            } else {
                                throw HttpSwiftError.responseError
                            }
                        }
                        
                    } else {
                        throw HttpSwiftError.statusCodeNotSuccess
                    }
                default:
                    fatalError()
                }
            } catch {
                handler(error)
            }
            
            }.resume()
    }
    
    //Execute Request
    open func `do`() {
        guard let _ = request.url else {
            return
        }
        
        session.dataTask(with: request.createRequest()).resume()
    }
}
