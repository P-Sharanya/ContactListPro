import Foundation

final class ContactStorage {
    static let shared = ContactStorage()

    private let userDefaultsKey = "savedContacts"
    private var contacts: [Contact] = []

    private init() {
        loadContacts()
    }

    // MARK: - CRUD Methods

    func getAllContacts() -> [Contact] {
        return contacts
    }

    func addContact(_ contact: Contact) throws {
        contacts.append(contact)
        try saveContacts()
    }

    func deleteContact(_ contact: Contact) throws {
        contacts.removeAll { $0.id == contact.id }
        try saveContacts()
    }

    func updateContact(_ contact: Contact) throws {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
            try saveContacts()
        }
    }

    // MARK: - Persistence

    private func saveContacts() throws{
        do {
            let data = try JSONEncoder().encode(contacts)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            throw StorageError.failedToSave(error.localizedDescription)

        }
    }

    private func loadContacts() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return }
        do {
            contacts = try JSONDecoder().decode([Contact].self, from: data)
        } catch {

            contacts = []
        }
    }
}

enum StorageError: Error, LocalizedError {
    case failedToSave(String)

    var errorDescription: String? {
        switch self {
        case .failedToSave(let message):
            return "Failed to save contacts: \(message)"
        }
    }
}
