import Foundation

final class ContactListPresenter: ObservableObject {
    @Published var contacts: [Contact] = []
    
    private let interactor: ContactListInteractor
    private let router: ContactListRouter
    
    init(interactor: ContactListInteractor, router: ContactListRouter) {
        self.interactor = interactor
        self.router = router
        loadContacts()
    }
    
    func loadContacts() {
        contacts = interactor.fetchContacts()
    }
    
    func addButtonTapped() {
        router.presentAddContact()
    }
    
    func contactTapped(_ contact: Contact) {
        router.presentDetail(for: contact)
    }
    
    func delete(at offsets: IndexSet) {
        interactor.deleteContact(at: offsets)
        loadContacts() // Refresh after delete
    }
}

