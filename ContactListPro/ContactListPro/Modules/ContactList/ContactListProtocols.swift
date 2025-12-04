import UIKit
import SwiftUI

// MARK: - View
protocol ContactListViewProtocol {
}

// MARK: - Presenter
protocol ContactListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loadLocalContacts()
    func didSelectContact(_ contact: Contact)
    func refreshAfterAdd()
    func didTapAddContact()
    func refreshAfterDelete() async
}

// MARK: - Interactor
protocol ContactListInteractorProtocol: AnyObject {
    func fetchLocalContacts() async -> [Contact]
    func fetchAPIContacts() async throws -> [Contact]
    func deleteContact(_ contact: Contact) throws
}

// MARK: - Router
protocol ContactListRouterProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    func navigationToAddContacts(refreshCallback: (() async -> Void)?)
    func navigationToContactDetail(_ contact: Contact, refreshCallback: (() async -> Void)?)
}

// MARK: - Builder
protocol ContactListBuilderProtocol {
    func build(navigationController: UINavigationController) -> UIViewController
}

