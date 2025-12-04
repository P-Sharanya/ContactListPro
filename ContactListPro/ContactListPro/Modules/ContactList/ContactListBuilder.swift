import UIKit
import SwiftUI

final class ContactListBuilder: ContactListBuilderProtocol {
    
    func build(navigationController: UINavigationController) -> UIViewController {
        
        let networkHandler = NetworkHandler()
        let interactor = ContactListInteractor(networkHandler: networkHandler)
        let router = ContactListRouter()
        let presenter = ContactListPresenter(interactor: interactor, router: router)
        
        let view = ContactListView(presenter: presenter)
        let hostingVC = UIHostingController(rootView: view)
    
        router.navigationController = navigationController
  
        return hostingVC
    }
}
