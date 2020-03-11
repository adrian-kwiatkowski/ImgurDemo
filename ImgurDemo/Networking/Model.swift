struct Welcome: Codable {
    let data: [ImageData]
    let success: Bool
    let status: Int
}

struct ImageData: Codable {
    let id: String
    let link: String
}
