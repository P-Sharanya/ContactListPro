import UIKit

final class ContactDetailRouter: ContactDetailRouterProtocol {
    weak var navigationController: UINavigationController?

    func navigateBackToContactList() {
        navigationController?.popViewController(animated: true)
    }
}

