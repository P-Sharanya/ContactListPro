import UIKit
import SwiftUI

final class ContactListRouter: ContactListRouterProtocol {

    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
    init(viewController: UIViewController? = nil, navigationController: UINavigationController? = nil) {
        self.viewController = viewController
        self.navigationController = navigationController
    }

    func navigationToAddContacts() {
        
        let addContactBuilder = AddContactBuilder()


        let addContactVC = addContactBuilder.build { [weak self] in
            if let hostingVC = self?.viewController as? UIHostingController<ContactListView> {
                hostingVC.rootView.presenter.viewDidLoad()
            }
        }
        navigationController?.pushViewController(addContactVC, animated: true)
    }

    func navigationToContactDetail(contact: Contact) {
        let contactDetailBuilder = ContactDetailBuilder()
        
        let detailVC = contactDetailBuilder.build(with: contact)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

