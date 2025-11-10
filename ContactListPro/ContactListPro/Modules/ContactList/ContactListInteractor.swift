import Foundation

final class ContactListInteractor {
    private let storage = ContactStorage()
    
    func fetchContacts() -> [Contact] {
        storage.fetch()
    }
    
    func deleteContact(at offsets: IndexSet) {
        var contacts = storage.fetch()
        contacts.remove(atOffsets: offsets)
        storage.save(contacts)
    }
}
