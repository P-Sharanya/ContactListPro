import Foundation
import UIKit
// MARK: - View
protocol AddContactViewProtocol {

}

// MARK: - Presenter
protocol AddContactPresenterProtocol: AnyObject {
    func didTapSave(name: String, phone: String, email: String)
    func didTapCancel()
}

// MARK: - Interactor
protocol AddContactInteractorProtocol: AnyObject {
    
    func saveContact(name: String, phone: String, email: String) throws
}

// MARK: - Router
protocol AddContactRouterProtocol: AnyObject {
    func dismiss()
}

// MARK: - Builder
protocol AddContactBuilderProtocol {
    func build(onContactAdded: @escaping () -> Void) -> UIViewController
}
