import Foundation

final class ContactDetailInteractor: ContactDetailInteractorProtocol {
    func deleteContact(_ contact: Contact) throws {
       try ContactStorage.shared.deleteContact(contact)
    }

    func updateContact(_ contact: Contact) throws {
       try ContactStorage.shared.updateContact(contact)
    }
}
