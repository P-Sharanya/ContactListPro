import Foundation

struct Contact: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var phone: String
    var email: String

    init(id: UUID = UUID(), name: String, phone: String, email: String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
    }
}

