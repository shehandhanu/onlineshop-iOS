import Foundation

// MARK: - Welcome
struct GetProductResponse: Codable {
    let success: Bool
    let count: Int
    let product: [Product]
}

// MARK: - Product
struct Product: Hashable, Identifiable, Codable {
    let id, productName, type, productDescription: String
    let image: String
    let price: Double
    let availability, v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productName, type, productDescription, image, price, availability
        case v = "__v"
    }
}
