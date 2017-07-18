import Foundation

open class Request {
    open var url: String!
    open var headers: [String: String]?
    open var params: [String: String]?
    open var cookies: [String: String]?
    open var method: HttpMethod!
    open var contentsType: ContentsType?
    
    func createRequest() -> URLRequest {
        
        var request = URLRequest(url: URL(string: self.url)!)
        
        //Set Http Method
        request.verb = method
        
        if let params = self.params {
            
            if request.isURIParam() {
                request.appendParams(params: params)
            } else {
                request.appendParamsIntoBody(params: params)
            }
        }
        
        //Set Cookie
        if let cookies = self.cookies {
            for(key, val) in cookies {
                request.addValue(key + "=" + val, forHTTPHeaderField: "Cookie")
            }
            
            request.httpShouldHandleCookies = true
        }
        
        //Set Contects Type
        if let type = contentsType {
            request.addValue(type.rawValue, forHTTPHeaderField: "Content-Type")
        }
        
        //Set Custom Header
        if let headers = self.headers {
            for (key, val) in headers {
                request.addValue(val, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
}
