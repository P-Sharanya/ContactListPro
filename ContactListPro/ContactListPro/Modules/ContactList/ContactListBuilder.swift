import UIKit
import SwiftUI

final class ContactListBuilder: ContactListBuilderProtocol {

    func build(navigationController: UINavigationController) -> UIViewController {
        
        let networkHandler = NetworkHandler()
        let interactor = ContactListInteractor(networkHandler: networkHandler)
        let router = ContactListRouter()
        router.navigationController = navigationController
        let presenter = ContactListPresenter(interactor: interactor, router: router)

        
        let view = ContactListView(presenter: presenter)
        let hostingVC = UIHostingController(rootView: view)
        
       
        hostingVC.view.backgroundColor = .white

      
        interactor.presenter = presenter
        presenter.view = view
        router.viewController = hostingVC

        return hostingVC
    }
}
