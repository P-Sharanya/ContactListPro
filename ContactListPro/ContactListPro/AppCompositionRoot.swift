import UIKit

final class AppCompositionRoot {
    static func createRootViewController() -> UIViewController {
        let navigationController = UINavigationController()
        let contactListVC = ContactListBuilder.build(navigationController: navigationController)
        navigationController.viewControllers = [contactListVC]
        return navigationController
    }
}
