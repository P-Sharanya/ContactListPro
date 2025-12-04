
import Foundation

// MARK: - String Regex Helper
extension String {
    func matches(_ pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression) != nil
    }
}
// MARK: - Presenter
final class AddContactPresenter: ObservableObject, AddContactPresenterProtocol {
    
    private let interactor: AddContactInteractorProtocol
    private let router: AddContactRouterProtocol
    @Published var activeAlert: AppAlert?
    private let refreshCallback: (() async -> Void)?

    
    init(interactor: AddContactInteractorProtocol,
         router: AddContactRouterProtocol, refreshCallback: (() async -> Void)? = nil) {
        self.interactor = interactor
        self.router = router
        self.refreshCallback = refreshCallback
    }
    
    // MARK: - Actions
    func didTapSave(name: String, phone: String, email: String) {
        do {
            try validate(name: name, phone: phone, email: email)
            try interactor.saveContact(name: name, phone: phone, email: email)
            
            Task{
                await refreshCallback?()
            }
            
            router.dismiss()
        }
        catch let error as AddContactValidationError{
            activeAlert = .error(error.localizedDescription)
        }
        catch{
            activeAlert = .error("Failed to Save contact.")
        }
    }
    
    func didTapCancel() {
        router.dismiss()
    }
    
    // MARK: - Validation
    private func validate(name: String, phone: String, email: String) throws {
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty { throw AddContactValidationError.emptyName }
        if trimmedPhone.isEmpty { throw AddContactValidationError.emptyPhone }
   
        if !trimmedPhone.matches(#"^\+?[\d\s\-\.\(\)]{3,}(?:\s*(?:x|ext|extension|#)\s*\d+)?$"#) {
            throw AddContactValidationError.invalidPhone
        }
        if trimmedEmail.isEmpty { throw AddContactValidationError.emptyEmail }
      
        if !trimmedEmail.matches("^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$") {
            throw AddContactValidationError.invalidEmail
        }
    }
}


