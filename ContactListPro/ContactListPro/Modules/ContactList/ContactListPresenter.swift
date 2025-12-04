import Foundation

final class ContactListPresenter: ObservableObject, ContactListPresenterProtocol {
    
    @Published var loadingState: LoadingStates = .idle
    @Published var activeAlert: AppAlert?
    @Published var contacts: [Contact] = []
    @Published var isRemoteList = false
    
    private let interactor: ContactListInteractorProtocol
    private let router: ContactListRouterProtocol
    
    private var apiContacts: [Contact] = []
    private var localContacts: [Contact] = []
    
    init(interactor: ContactListInteractorProtocol, router: ContactListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Sorting Helper
    private func sortMerged(_ contacts: [Contact]) -> [Contact] {
        contacts.sorted { a, b in
            if a.isFromAPI == b.isFromAPI {
                return a.name.lowercased() < b.name.lowercased()
            }
            return a.isFromAPI == false
        }
    }
    
    // MARK: - Entry
   func viewDidLoad() {
        loadingState = .idle
        
        if !apiContacts.isEmpty || !localContacts.isEmpty {
            mergeAndDisplayContacts()
            return
        }
        
        Task {
            try? await Task.sleep(nanoseconds: 200_000_000)
            let placeholders = Array(repeating: Contact(name: "Loading...", phone: "------", email: "-----"), count: 6)
            await MainActor.run {
                self.loadingState = .loading(placeholders)
            }
            
            do {
                let fetchedAPI = try await interactor.fetchAPIContacts()
                await MainActor.run {
                    self.apiContacts = fetchedAPI.map {
                        var c = $0
                        c.isFromAPI = true
                        return c
                    }
                }
            } catch {
                await MainActor.run {
                    self.loadingState = .error("Failed to load API contacts.", true)
                }
            }
           
            let local = await interactor.fetchLocalContacts()
            await MainActor.run {
                self.localContacts = local
                self.mergeAndDisplayContacts()
            }
        }
    }

    private func mergeAndDisplayContacts() {
        var merged: [Contact] = []
        merged.append(contentsOf: self.localContacts)
        merged.append(contentsOf: self.apiContacts.filter { api in
            !self.localContacts.contains(where: { $0.id == api.id })
        })
        let sorted = self.sortMerged(merged)
        self.contacts = sorted
        self.loadingState = .loaded(sorted)
        
    }
    
 

    func didConfirmDelete(_ contact: Contact) {
        activeAlert = nil
        
        Task {
            do {
              
                try interactor.deleteContact(contact)

                await MainActor.run {
                    activeAlert = .success("Contact deleted successfully")
                    self.localContacts.removeAll(where: { $0.id == contact.id })
                    self.mergeAndDisplayContacts()
                }

            } catch {
                await MainActor.run {
                    self.activeAlert = .error("Failed to delete contact.")
                }
            }
        }
    }
    func didTapAPIContacts() {
        isRemoteList = true
        viewDidLoad()
    }
    
    func loadLocalContacts() {
        isRemoteList = false
        Task {
            let local = await interactor.fetchLocalContacts()
            await MainActor.run {
                self.localContacts = local
                mergeAndDisplayContacts()
            }
        }
    }
    
    // MARK: - Navigation to detail
    func didSelectContact(_ contact: Contact) {
        router.navigationToContactDetail(contact, refreshCallback: { [weak self] in
            await self?.refreshAfterDelete()
        })

    }

    func didTapAddContact() {
        router.navigationToAddContacts { [weak self] in
            await self?.refreshAfterAdd()
        }
    }
    func requestDelete(_ contact: Contact) {
        activeAlert = .confirmDelete(contact)
    }
    // MARK: - Refresh flows
    func refreshAfterAdd() {
        Task {
            let local = await interactor.fetchLocalContacts()
            await MainActor.run {
                self.localContacts = local
                mergeAndDisplayContacts()
            }
        }
    }
    
    func refreshAfterDelete() async {
        let local = await interactor.fetchLocalContacts()
        await MainActor.run {
            self.localContacts = local
            mergeAndDisplayContacts()
        }
    }
}
