import SwiftUI

@main
struct ContactListProApp: App {
    @StateObject var router = AppRouter.shared   // ✅ AppRouter is ObservableObject
    
    var body: some Scene {
        WindowGroup {
            switch router.currentRoute {
            case .contactList:
                let interactor = ContactListInteractor()
                let listRouter = ContactListRouter()
                let presenter = ContactListPresenter(interactor: interactor, router: listRouter)
                ContactListView(presenter: presenter)
                    .environmentObject(router) // ✅ Pass router as EnvironmentObject
                
            case .addContact:
                NavigationView {
                    AddContactView()
                        .environmentObject(router)
                }
                
            case .contactDetail:
                if let contact = router.selectedContact {
                    NavigationView {
                        ContactDetailView(contact: contact)
                            .environmentObject(router) // ✅ Needed
                    }
                }

            }
        }
    }
}

