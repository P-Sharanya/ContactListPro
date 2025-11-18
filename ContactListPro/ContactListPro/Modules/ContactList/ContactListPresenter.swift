import Foundation

final class ContactListPresenter: ObservableObject, ContactListPresenterProtocol {
    var view: ContactListViewProtocol?
    private let interactor: ContactListInteractorProtocol?
    private let router: ContactListRouterProtocol?

    @Published private(set) var contacts: [Contact] = []
    
    
    @Published var isRemoteList = false

    init(interactor: ContactListInteractorProtocol?, router: ContactListRouterProtocol?) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        if isRemoteList {
            interactor?.fetchAPIContacts()
            
        }else{
            interactor?.fetchContacts()
        }
    }
    func loadLocalContacts() {
         isRemoteList = false
         interactor?.fetchContacts()
     }

    func didFetchContacts(_ contacts: [Contact]) {
        DispatchQueue.main.async {
            self.contacts = contacts
            
            if contacts.isEmpty {
                self.view?.showEmptyState()
            } else {
                self.view?.showContacts(contacts)
            }
        }
    }

    func didSelectContact(_ contact: Contact) {
        router?.navigationToContactDetail(contact: contact)
    }

    func didTapAddContact() {
        router?.navigationToAddContacts()
    }
    
    // MARK: - NEW: API Contacts Call
        func didTapAPIContacts() {
            isRemoteList = true
            interactor?.fetchAPIContacts()
        }


        func didFetchAPIContacts(_ contacts: [Contact]) {
            DispatchQueue.main.async {
                self.contacts = contacts
                self.view?.showContacts(contacts)
            }
        }
    
}
