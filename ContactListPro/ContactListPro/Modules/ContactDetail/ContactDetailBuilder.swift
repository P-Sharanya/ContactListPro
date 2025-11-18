import UIKit
import SwiftUI

final class ContactDetailBuilder {
    func build(with contact: Contact) -> UIViewController {
        
        let interactor = ContactDetailInteractor()
        let router = ContactDetailRouter()
        let presenter = ContactDetailPresenter(contact: contact,
                                               interactor: interactor,
                                               router: router)

  
        let existing = ContactStorage.shared.getAllContacts().contains { $0.id == contact.id }
        presenter.isRemote = !existing
        
        
        let view = ContactDetailView(presenter: presenter)
        let hostingVC = UIHostingController(rootView: view)
        

        DispatchQueue.main.async {
            router.navigationController = hostingVC.navigationController
        }

        return hostingVC
    }
}

