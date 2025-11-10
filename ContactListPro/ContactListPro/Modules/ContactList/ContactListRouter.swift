import SwiftUI

final class ContactListRouter {
    func presentAddContact() {
        AppRouter.shared.currentRoute = .addContact
    }
    
    func presentDetail(for contact: Contact) {
        AppRouter.shared.selectedContact = contact
        AppRouter.shared.currentRoute = .contactDetail
    }
}
