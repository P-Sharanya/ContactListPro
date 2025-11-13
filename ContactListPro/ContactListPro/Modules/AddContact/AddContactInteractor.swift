import Foundation

final class AddContactInteractor: AddContactInteractorProtocol {
    weak var presenter: AddContactPresenterProtocol?

    func validateContact(name: String, phone: String, email: String) -> Bool {
        guard !name.isEmpty else { return false }

        let phoneRegex = "^[0-9]{10}$"
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"

        let phoneValid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        let emailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)

        return phoneValid && emailValid
    }

    func saveContact(name: String, phone: String, email: String) {
        let newContact = Contact(name: name, phone: phone, email: email)
        ContactStorage.shared.addContact(newContact)
    }
}
