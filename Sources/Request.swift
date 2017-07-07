import Foundation

open class Request {
    open var url: String!
    open var params: [String: String]?
    open var method: HttpMethod!
    open var contentsType: ContentsType?
    
    func createRequest() -> URLRequest {
        var urlComponent = URLComponents(string: url)!
        
        //Set Request Parameter
        if let params = params {
            urlComponent.queryItems = params.map { key, val in
                return URLQueryItem(name: key, value: val)
            }
        }
        
        var request = URLRequest(url: urlComponent.url!)
        
        //Set Http Method
        request.httpMethod = method.description()
        
        
        //Set Content-Type
        if let type = contentsType {
            request.addValue(type.rawValue, forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
