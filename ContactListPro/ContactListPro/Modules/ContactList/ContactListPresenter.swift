import Foundation

final class ContactListPresenter: ObservableObject, ContactListPresenterProtocol {
    var view: ContactListViewProtocol?
    private let interactor: ContactListInteractorProtocol?
    private let router: ContactListRouterProtocol?

    @Published private(set) var contacts: [Contact] = []

    init(interactor: ContactListInteractorProtocol?, router: ContactListRouterProtocol?) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
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
}
