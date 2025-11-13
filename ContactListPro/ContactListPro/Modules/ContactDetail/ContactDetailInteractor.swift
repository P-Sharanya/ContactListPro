import Foundation

final class ContactDetailInteractor: ContactDetailInteractorProtocol {
    func deleteContact(_ contact: Contact) {
        ContactStorage.shared.deleteContact(contact)
    }

    func updateContact(_ contact: Contact) {
        ContactStorage.shared.updateContact(contact)
    }
}
