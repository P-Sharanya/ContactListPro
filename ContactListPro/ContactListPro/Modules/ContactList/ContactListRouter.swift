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
        let addContactVC = AddContactBuilder.build { [weak self] in
            if let hostingVC = self?.viewController as? UIHostingController<ContactListView> {
                hostingVC.rootView.presenter.viewDidLoad()
            }
        }
        navigationController?.pushViewController(addContactVC, animated: true)
    }

    func navigationToContactDetail(contact: Contact) {
        let detailVC = ContactDetailBuilder.build(with: contact)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

