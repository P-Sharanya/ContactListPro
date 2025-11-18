
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

        do {
            try validate(name: name, phone: phone, email: email)
            try interactor.saveContact(name: name, phone: phone, email: email)

            onContactAdded()
            router.dismiss()

        } catch let error as AddContactValidationError {
            view?.showValidationError(error.localizedDescription)
        } catch let error as StorageError {
            view?.showValidationError(error.localizedDescription)
        } catch {
            view?.showValidationError("An unexpected error occurred.")
        }
    }

    private func validate(name: String, phone: String, email: String) throws {

        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedName.isEmpty {
            throw AddContactValidationError.emptyName
        }

        if trimmedPhone.isEmpty {
            throw AddContactValidationError.emptyPhone
        }
        if !trimmedPhone.matches("^[0-9]{10}$") {
            throw AddContactValidationError.invalidPhone
        }

        if trimmedEmail.isEmpty {
            throw AddContactValidationError.emptyEmail
        }
        if !trimmedEmail.matches("^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$") {
            throw AddContactValidationError.invalidEmail
        }
    }

    func didTapCancel() {
        router.dismiss()
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
