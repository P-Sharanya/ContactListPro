import Foundation

final class ContactListInteractor: ContactListInteractorProtocol {
    
    var presenter: ContactListPresenterProtocol?
    private let networkHandler: NetworkHandler

    init(networkHandler: NetworkHandler) {
        self.networkHandler = networkHandler
    }
    func fetchLocalContacts() async -> [Contact] {
        return await networkHandler.fetchLocalContacts()
    }
    func fetchAPIContacts() async throws -> [Contact] {
        return try await networkHandler.fetchAPIContacts()
    }
    func deleteContact(_ contact: Contact) throws {
        try ContactStorage.shared.deleteContact(contact)
        }

}
