import Foundation

final class AddContactPresenter: ObservableObject, AddContactPresenterProtocol {
    private let interactor: AddContactInteractorProtocol
    private let router: AddContactRouterProtocol
    var view: AddContactViewProtocol?
    private let onContactAdded: () -> Void

    init(interactor: AddContactInteractorProtocol,
         router: AddContactRouterProtocol,
         onContactAdded: @escaping () -> Void) {
        self.interactor = interactor
        self.router = router
        self.onContactAdded = onContactAdded
    }

    func didTapSave(name: String, phone: String, email: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        var nameInvalid = false
        var phoneInvalid = false
        var emailInvalid = false

     
        
        if trimmedName.isEmpty {
            nameInvalid = true
        }
        if trimmedPhone.isEmpty {
            phoneInvalid = true
        } else if !NSPredicate(format: "SELF MATCHES %@", "^[0-9]{10}$").evaluate(with: trimmedPhone) {
            phoneInvalid = true
        }
        if trimmedEmail.isEmpty {
            emailInvalid = true
        } else if !NSPredicate(format: "SELF MATCHES %@", "^[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$").evaluate(with: trimmedEmail) {
            emailInvalid = true
        }

      
        view?.highlightInvalidFields(
            nameInvalid: nameInvalid,
            phoneInvalid: phoneInvalid,
            emailInvalid: emailInvalid
        )

     
        if nameInvalid {
            view?.showValidationError("Name is required.")
            return
        }
        if phoneInvalid && trimmedPhone.isEmpty {
            view?.showValidationError("Phone number is required.")
            return
        }
        if phoneInvalid && !trimmedPhone.isEmpty {
            view?.showValidationError("Phone number must be exactly 10 digits.")
            return
        }
        if emailInvalid && trimmedEmail.isEmpty {
            view?.showValidationError("Email address is required.")
            return
        }
        if emailInvalid && !trimmedEmail.isEmpty {
            view?.showValidationError("Please enter a valid email address.")
            return
        }

        
        interactor.saveContact(name: trimmedName, phone: trimmedPhone, email: trimmedEmail)
        onContactAdded()
        router.dismiss()
    }

    func didTapCancel() {
        router.dismiss()
    }
}
