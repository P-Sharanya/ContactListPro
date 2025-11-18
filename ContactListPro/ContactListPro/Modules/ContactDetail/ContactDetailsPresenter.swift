import Foundation

final class ContactDetailPresenter: ObservableObject, ContactDetailPresenterProtocol {
    @Published var contact: Contact
    private let interactor: ContactDetailInteractorProtocol
    private let router: ContactDetailRouterProtocol
    var view: ContactDetailViewProtocol?
    
    
    var isRemote: Bool = false


    init(contact: Contact,
         interactor: ContactDetailInteractorProtocol,
         router: ContactDetailRouterProtocol) {
        self.contact = contact
        self.interactor = interactor
        self.router = router
    }

    func didTapSaveEdit(name: String, phone: String, email: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        // MARK: - Validation
        if trimmedName.isEmpty {
            view?.showAlert(message: "Name is required.", success: false)
            return
        }

        if phone.trimmingCharacters(in: .whitespaces).isEmpty {
            view?.showAlert(message: "Phone number is required.", success: false)
            return
        }

        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            view?.showAlert(message: "Email address is required.", success: false)
            return
        }

        let phoneRegex = "^[0-9]{10}$"
        if !NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone) {
            view?.showAlert(message: "Phone number must contain exactly 10 digits.", success: false)
            return
        }

        let emailRegex = "^[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$"
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            view?.showAlert(message: "Please enter a valid email address.", success: false)
            return
        }

        // MARK: - Save Changes
        contact.name = trimmedName
        contact.phone = phone
        contact.email = email

        do {
            try interactor.updateContact(contact)
            view?.showAlert(message: "Contact updated successfully!", success: true)
        } catch {
            view?.showAlert(message: "Failed to update contact: \(error.localizedDescription)", success: false)
        }
    }
    func didTapDelete() {
        do {
            try interactor.deleteContact(contact)
            router.navigateBackToContactList()
        } catch {
            view?.showAlert(message: "Failed to delete contact: \(error.localizedDescription)", success: false)
        }
    }

}

