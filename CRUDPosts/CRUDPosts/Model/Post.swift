import Foundation

struct Post: Codable {
    let id: Int?
    let title: String?
    let message: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title = "post_title"
        case message = "post_message"
        case image = "post_image"
    }
}
