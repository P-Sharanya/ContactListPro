import Foundation
import UIKit

// MARK: - View
protocol ContactDetailViewProtocol {

    func showAlert(message: String, success: Bool)
}

// MARK: - Presenter
protocol ContactDetailPresenterProtocol: AnyObject {
    var contact: Contact { get set }
    func didTapDelete()
    func didTapSaveEdit(name: String, phone: String, email: String)
}

// MARK: - Interactor
protocol ContactDetailInteractorProtocol: AnyObject {
   
    func deleteContact(_ contact: Contact) throws

    func updateContact(_ contact: Contact) throws
}

// MARK: - Router
protocol ContactDetailRouterProtocol: AnyObject {

    func navigateBackToContactList()
}

// MARK: - Builder
protocol ContactDetailBuilderProtocol {
    func build(with contact: Contact) -> UIViewController
}

