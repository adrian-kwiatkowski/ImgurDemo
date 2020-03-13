import UIKit
import Foundation
import PromiseKit

struct NetworkService {
    
    enum NetworkError: Error {
        case invalidURL
        case unknown
        case encoding
    }
    
    func perform<T: Codable>(_ request: URLRequest, _ seal: Resolver<T>) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, let result = try? JSONDecoder().decode(T.self, from: data) else {
                seal.reject(error ?? NetworkError.unknown)
                return
            }
            
            seal.fulfill(result)
        }.resume()
    }
    
    func fetchImages() -> Promise<ImagesResponse> {
        return Promise { seal in
            guard let url = UrlBuilder.buildURL(for: .accountImages) else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            
            let request = RequestBuilder.buildRequest(with: url, httpMethod: .get)
            
            perform(request, seal)
        }
    }
    
    func upload(_ image: UIImage) -> Promise<SingleImageResponse> {
        return Promise { seal in
            guard let url = UrlBuilder.buildURL(for: .uploadImage) else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            
            var request = RequestBuilder.buildRequest(with: url, httpMethod: .post)
            
            guard let imageBase64 = image.toBase64() else {
                seal.reject(NetworkError.encoding)
                return
            }
            
            let json: [String: Any] = ["image": imageBase64, "type": "base64"]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            
            perform(request, seal)
        }
    }
    
    func deleteImage(with deleteHash: String) -> Promise<DeleteImageResponse> {
        return Promise { seal in
            guard let url = UrlBuilder.buildURL(for: .deleteImage) else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            
            let newUrl =  url.appendingPathComponent(deleteHash)
            let request = RequestBuilder.buildRequest(with: newUrl, httpMethod: .delete)
            
            perform(request, seal)
        }
    }
}
