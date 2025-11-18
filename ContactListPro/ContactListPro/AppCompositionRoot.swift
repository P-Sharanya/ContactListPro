import UIKit

final class AppCompositionRoot {

     func createRootViewController() -> UIViewController {
        let navigationController = UINavigationController()
        let contactListBuilder = ContactListBuilder()

        
        let contactListVC = contactListBuilder.build(navigationController: navigationController)
        navigationController.viewControllers = [contactListVC]
        return navigationController
    }
}
