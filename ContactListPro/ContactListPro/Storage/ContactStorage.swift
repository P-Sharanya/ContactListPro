import Foundation

final class ContactStorage {
    private let key = "contacts_key"
    
    func save(_ contacts: [Contact]) {
        if let data = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func fetch() -> [Contact] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let contacts = try? JSONDecoder().decode([Contact].self, from: data)
        else { return [] }
        return contacts
    }
}
