import UIKit

final class ContactDetailRouter: ContactDetailRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func navigateBackToContactList() {
        navigationController?.popViewController(animated: true)
    }
}

