import Foundation

final class ContactListInteractor: ContactListInteractorProtocol {
    var presenter: ContactListPresenterProtocol?
    private let networkHandler: NetworkHandler

    init(networkHandler: NetworkHandler) {
        self.networkHandler = networkHandler
    }

    func fetchContacts() {
        networkHandler.fetchContacts { [weak self] contacts in
            self?.presenter?.didFetchContacts(contacts)
        }
    }
}
