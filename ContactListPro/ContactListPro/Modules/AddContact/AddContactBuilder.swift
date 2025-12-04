import UIKit
import SwiftUI

final class AddContactBuilder {
    func build(navigationController: UINavigationController?,refreshCallback: (() async -> Void)? = nil) -> UIViewController {
        let interactor = AddContactInteractor()
        let router = AddContactRouter()
        let presenter = AddContactPresenter(interactor: interactor, router: router, refreshCallback: refreshCallback)
        
        let view = AddContactView(presenter: presenter)

        let hostingVC = UIHostingController(rootView: view)
        
        router.navigationController = navigationController
        return hostingVC
    }
}
