import Foundation

struct UrlBuilder {
    
    enum Endpoint: String {
        case accountImages = "/3/account/me/images"
        case uploadImage = "/3/upload"
        case deleteImage = "/3/image/"
    }
    
    static func buildURL(for endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.imgur.com"
        components.path = endpoint.rawValue
        
        return components.url
    }
}
