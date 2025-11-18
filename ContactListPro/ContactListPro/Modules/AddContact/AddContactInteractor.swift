import Foundation

final class AddContactInteractor: AddContactInteractorProtocol {

    
    func saveContact(name: String, phone: String, email: String) throws {
        let newContact = Contact(name: name, phone: phone, email: email)

        do {
            try ContactStorage.shared.addContact(newContact)
        } catch {
            throw error
        }
    }

}
