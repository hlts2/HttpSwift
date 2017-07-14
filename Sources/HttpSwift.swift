import Foundation

public enum HttpMethod: String {
    case GET        = "GET"
    case POST       = "POST"
    case PUT        = "PUT"
    case DELETE     = "DELETE"
    case PATCH      = "PATCH"
    case HEAD       = "HEAD"
    case UNKNOWN    = "UNKNOWN"
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
    
    //Add Content-type into Request Header
    open func setContentsType(_ type: ContentsType) -> HTTP {
        request.contentsType = type
        return self
    }
    
    //Add Request Parameter
    open func setQuery(params: [String: String]) -> HTTP {
        self.request.params = params
        return self
    }
    
    //Add Request Custom Header
    open func setHeader(headers: [String: String]) -> HTTP {
        self.request.headers = headers
        return self
    }
    
    open func setCookie(cookies: [String: String]) -> HTTP {
        //TODO setting cookie
        return self
    }
    
    open func addHeader(headers: [String: String]) -> HTTP {
        guard let _ = self.request.headers else {
            self.request.headers = headers
            return self
        }
        
        for (key, value) in headers {
            self.request.headers![key] = value
        }
        
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
    
    open func cancel() {
        session.invalidateAndCancel()
    }
    
    
    //Execute Request
    open func `do`(handler: @escaping (Result<Any, HttpSwiftError>) -> ()) {
        guard let _ = request.url else {
            return
        }
        
        session.dataTask(with: request.createRequest()) { data, response, error in
            
            switch(data, response, error) {
            case(_, _, let error?):
                handler(Result(error: .connectionError(error)))
            case(let data?, let resp, _):
                
                //Check Status Code
                if 200..<300 ~= (resp as! HTTPURLResponse).statusCode {
                    
                    //Check Contents Type
                    switch self.request.contentsType {
                    case .json?:
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            handler(Result(value: json))
                        } catch {
                            handler(Result(error: .responseError))
                        }
                    default:
                        if let str = String(data: data, encoding: .utf8) {
                            handler(Result(value: str))
                        } else {
                            handler(Result(error: .responseError))
                        }
                    }
                } else {
                    handler(Result(error: .statusCodeNotSuccess))
                }
            default:
                fatalError("invalid response")
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
