// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: [ImageData]
    let success: Bool
    let status: Int
}

// MARK: - Datum
struct ImageData: Codable {
    let id: String
    let link: String
}
