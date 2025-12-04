import UIKit
import SwiftUI

final class ContactListRouter: ContactListRouterProtocol {
     
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func navigationToAddContacts(refreshCallback: (() async -> Void)? = nil) {
        let addVC = AddContactBuilder().build(navigationController: navigationController, refreshCallback: refreshCallback)
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func navigationToContactDetail(_ contact: Contact, refreshCallback: (() async -> Void)?) {
        
        let vc = ContactDetailBuilder().build(contact: contact, navigationController: navigationController, refreshCallback: refreshCallback)
        navigationController?.pushViewController(vc, animated: true)
    }
}

