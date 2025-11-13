import SwiftUI
import UIKit

final class AddContactBuilder {
    static func build(onContactAdded: @escaping () -> Void) -> UIViewController {
        let interactor = AddContactInteractor()
        let router = AddContactRouter()
        let presenter = AddContactPresenter(
            interactor: interactor,
            router: router,
            onContactAdded: onContactAdded
        )

        let view = AddContactView(presenter: presenter)
        presenter.view = view  
        let hostingVC = UIHostingController(rootView: view)
        router.viewController = hostingVC
        return hostingVC
    }
}
