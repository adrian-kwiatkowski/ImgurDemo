struct ImagesResponse: Codable {
    let data: [ImageData]
    let success: Bool
    let status: Int
}

struct SingleImageResponse: Codable {
    let data: ImageData
    let success: Bool
    let status: Int
}

struct DeleteImageResponse: Codable {
    let data: Bool
    let success: Bool
    let status: Int
}

struct ImageData: Codable {
    let id: String
    let link: String
    let deletehash: String
}
