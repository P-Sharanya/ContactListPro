import Foundation

struct Contact: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var phone: String
    var email: String
    var isFromAPI: Bool = false
    
    
    
    
    init(id: UUID = UUID(), name: String, phone: String, email: String, isFromAPI: Bool = false) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.isFromAPI = isFromAPI
    }   
    
}



struct APIContact: Decodable {
    let name: String
    let phone: String
    let email: String
}
