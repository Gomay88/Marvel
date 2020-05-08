
import Foundation

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

open class RequestBuilder {
    
    fileprivate var host: String
    fileprivate var path: String
    
    fileprivate var headers: [String: String]
    fileprivate var parameter: Encodable?
    fileprivate var method: HTTPMethod
    
    fileprivate var urlTemplate: (String, String) -> (String)
    
    public init(host: String = "", urlTemplate: @escaping (String, String) -> (String) = {"\($0)\($1)"}) {
        self.host = host
        self.path = ""
        
        self.headers = [:]
        self.method = .get
        
        self.urlTemplate = urlTemplate
    }
    
    open func host(_ host: String) -> Self {
        self.host = host
        return self
    }
    
    open func path(_ path: String) -> Self {
        self.path = path
        return self
    }
    
    open func headers(_ headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    open func addOrUpdateHeader(key: String, value: String) -> Self {
        headers.updateValue(value, forKey: key)
        return self
    }
    
    open func parameter(_ parameter: Encodable) -> Self {
        self.parameter = parameter
        return self
    }
    
    open func method(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    open func get() -> Self {
        return method(.get)
    }
    
    open func post() -> Self {
        return method(.post)
    }
    
    open func put() -> Self {
        return method(.put)
    }
    
    open func delete() -> Self {
        return method(.delete)
    }
    
    open func builtHttpRequest() -> HttpRequest {
        let url = urlTemplate(host, path)
        
        return HttpRequest(stringURL: url, method: method, headers: headers, parameter: parameter)
    }
}

extension RequestBuilder {
    public static func marvel() -> RequestBuilder {
        return RequestBuilder(host: "https://gateway.marvel.com/v1/public") { (host, path) in
            return "\(host)/\(path)"
        }
    }
}
