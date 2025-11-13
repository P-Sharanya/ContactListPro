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

    func addContact(_ contact: Contact) {
        contacts.append(contact)
        saveContacts()
    }

    func deleteContact(_ contact: Contact) {
        contacts.removeAll { $0.id == contact.id }
        saveContacts()
    }

    func updateContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
            saveContacts()
        }
    }

    // MARK: - Persistence

    private func saveContacts() {
        do {
            let data = try JSONEncoder().encode(contacts)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("❌ Failed to save contacts: \(error)")
        }
    }

    private func loadContacts() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return }
        do {
            contacts = try JSONDecoder().decode([Contact].self, from: data)
        } catch {
            print("❌ Failed to load contacts: \(error)")
            contacts = []
        }
    }
}

