import Foundation

struct Contact: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var phone: String
    var email: String
}
