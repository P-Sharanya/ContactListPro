import Foundation
import UIKit
// MARK: - View
protocol AddContactViewProtocol {
    func showValidationError(_ message: String)
    func highlightInvalidFields(
        nameInvalid: Bool,
        phoneInvalid: Bool,
        emailInvalid: Bool
    )
}

// MARK: - Presenter
protocol AddContactPresenterProtocol: AnyObject {
    func didTapSave(name: String, phone: String, email: String)
    func didTapCancel()
}

// MARK: - Interactor
protocol AddContactInteractorProtocol: AnyObject {
    func validateContact(name: String, phone: String, email: String) -> Bool
    func saveContact(name: String, phone: String, email: String)
}

// MARK: - Router
protocol AddContactRouterProtocol: AnyObject {
    func dismiss()
}

// MARK: - Builder
protocol AddContactBuilderProtocol {
    static func build(onContactAdded: @escaping () -> Void) -> UIViewController
}
