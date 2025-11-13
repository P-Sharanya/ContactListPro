import UIKit

class AddContactRouter: AddContactRouterProtocol {
    weak var viewController: UIViewController?

    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
