import UIKit
import SwiftUI

final class ContactDetailBuilder: ContactDetailBuilderProtocol {
    
    func build( contact: Contact, navigationController: UINavigationController?, refreshCallback: (() async -> Void)? = nil) -> UIViewController {
   
        let interactor = ContactDetailInteractor()
        let router = ContactDetailRouter(navigationController: navigationController)
        
        let presenter = ContactDetailPresenter(contact: contact, interactor: interactor, router: router, refreshListCallback: refreshCallback)
    
        let view = ContactDetailView(presenter: presenter)
        let hosting = UIHostingController(rootView: view)
  
        return hosting
    }
}
