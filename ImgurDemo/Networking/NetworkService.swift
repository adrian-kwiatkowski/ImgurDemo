import UIKit
import Foundation
import PromiseKit

struct NetworkService {
    
    private let accessToken = "1c3853bbdcfabfc33ea5c043d12fb6495023849c"
    
    enum NetworkError: Error {
        case invalidURL
        case unknown
    }
    
    func fetchImages() -> Promise<Welcome> {
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
        request.setValue( "Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
          guard let data = data, let result = try? JSONDecoder().decode(Welcome.self, from: data) else {
            seal.reject(error ?? NetworkError.unknown)
            return
          }

          seal.fulfill(result)
        }.resume()
      }
    }
}
