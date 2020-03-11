import UIKit
import Foundation
import PromiseKit

struct NetworkService {
    
    private let accessToken = "1c3853bbdcfabfc33ea5c043d12fb6495023849c"
    
    enum NetworkError: Error {
        case invalidURL
        case unknown
        case encoding
    }
    
    func fetchImages() -> Promise<ImagesResponse> {
        return Promise { seal in
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.imgur.com"
            components.path = "/3/account/me/images"
            
            guard let url = components.url else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, let result = try? JSONDecoder().decode(ImagesResponse.self, from: data) else {
                    seal.reject(error ?? NetworkError.unknown)
                    return
                }
                
                seal.fulfill(result)
            }.resume()
        }
    }
    
    func upload(_ image: UIImage) -> Promise<SingleImageResponse> {
        return Promise { seal in
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.imgur.com"
            components.path = "/3/upload"
            
            guard let url = components.url else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            guard let imageBase64 = image.toBase64() else {
                seal.reject(NetworkError.encoding)
                return
            }
            
            let json: [String: Any] = ["image": imageBase64, "type": "base64"]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, let result = try? JSONDecoder().decode(SingleImageResponse.self, from: data) else {
                    seal.reject(error ?? NetworkError.unknown)
                    return
                }
                
                seal.fulfill(result)
            }.resume()
        }
    }
}
