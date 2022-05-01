
import Foundation

// MARK: - Welcome
struct GetCartResponse: Codable {
    let success: Bool
    let count: Int
    let cart: [Cart]
}

// MARK: - Order
struct Cart: Hashable, Identifiable, Codable {
    let id, userID, quantity: String
    let product: Product
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID, quantity, product
        case v = "__v"
    }
}
