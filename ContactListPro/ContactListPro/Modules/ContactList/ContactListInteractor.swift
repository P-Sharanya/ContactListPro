import Foundation

final class ContactListInteractor: ContactListInteractorProtocol {
    var presenter: ContactListPresenterProtocol?
    private let networkHandler: NetworkHandler

    init(networkHandler: NetworkHandler) {
        self.networkHandler = networkHandler
    }

    func fetchContacts() {
        networkHandler.fetchContacts { contacts in
            self.presenter?.didFetchContacts(contacts)
        }
    }
    
    // MARK: - NEW: API CONTACTS
    func fetchAPIContacts() {
        let apiURL = URL(string: "https://jsonplaceholder.typicode.com/users")!

        URLSession.shared.dataTask(with: apiURL) { data, response, error in
            guard let data = data else {
                self.presenter?.didFetchAPIContacts([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode([APIContact].self, from: data)
                let mapped = decoded.map {Contact(id: UUID(), name: $0.name, phone: $0.phone, email: $0.email, isFromAPI: true)
                }
                self.presenter?.didFetchAPIContacts(mapped)
            } catch {
                self.presenter?.didFetchAPIContacts([])
            }

        }.resume()
    }
}
