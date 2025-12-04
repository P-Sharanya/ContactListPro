import Foundation

final class ContactDetailPresenter: ObservableObject, ContactDetailPresenterProtocol {
    
    @Published var contact: Contact
    @Published var activeAlert: AppAlert?
    
    let router: ContactDetailRouterProtocol
    private let interactor: ContactDetailInteractorProtocol
    private let refreshListCallback: (() async -> Void)?
    
    init(contact: Contact,
         interactor: ContactDetailInteractorProtocol,
         router: ContactDetailRouterProtocol,
         refreshListCallback: (() async -> Void)? = nil) {

        self.contact = contact
        self.interactor = interactor
        self.router = router
        self.refreshListCallback = refreshListCallback
    }

    func didTapSaveEdit(name: String, phone: String, email: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedName.isEmpty {
            activeAlert = .error("Name is required.")
            return
        }
        if trimmedPhone.isEmpty {
            activeAlert = .error("Phone number is required.")
            return
        }
        if !trimmedPhone.matches(#"^\+?[\d\s\-\.\(\)]{3,}(?:\s*(?:x|ext|extension|#)\s*\d+)?$"#) {
            activeAlert = .error("Invalid Phone number format")
            return
        }
        if trimmedEmail.isEmpty {
            activeAlert = .error("Email is required.")
            return
        }
        if !trimmedEmail.matches("^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$") {
            activeAlert = .error("Enter a valid email address.")
            return
        }
       
        let updated = Contact(
            id: contact.id,
            name: trimmedName,
            phone: trimmedPhone,
            email: trimmedEmail,
            isFromAPI: contact.isFromAPI
        )
        do {
            try interactor.updateContact(updated)
            self.contact = updated
            self.activeAlert = .success("Contact updated successfully.")
            Task{
                await refreshListCallback?()
            }
        } catch {
            self.activeAlert = .error("Failed to update contact.")
        }
    }
  
    func requestDelete() {
        activeAlert = .confirmDelete(contact)
    }
    
    func deleteConfirmed() {
        do {
            try interactor.deleteContact(contact)
           
            activeAlert = .success("Contact deleted successfully.")
          
            Task {
                await refreshListCallback?()
            }
            
        } catch {
            activeAlert = .error("Failed to delete contact.")
        }
    }

    func afterDeleteSuccessNavigateBack() {
        router.navigateBackToContactList()
    }
}

