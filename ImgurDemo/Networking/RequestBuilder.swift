import Foundation

struct RequestBuilder {
    
    private static let accessToken = "1c3853bbdcfabfc33ea5c043d12fb6495023849c"
    
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }
    
    static func buildRequest(with url: URL, httpMethod: HttpMethod) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
