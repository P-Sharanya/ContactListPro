import UIKit

// MARK: - View
protocol ContactListViewProtocol {
    func showContacts(_ contacts: [Contact])
    func showEmptyState()
}

// MARK: - Presenter
protocol ContactListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectContact(_ contact: Contact)
    func didTapAddContact()
    func didFetchContacts(_ contacts: [Contact])
}

// MARK: - Interactor
protocol ContactListInteractorProtocol: AnyObject {
    func fetchContacts()
}

// MARK: - Router
protocol ContactListRouterProtocol: AnyObject {
    func navigationToAddContacts()
    func navigationToContactDetail(contact: Contact)
}

// MARK: - Builder
protocol ContactListBuilderProtocol {
    static func build(navigationController: UINavigationController) -> UIViewController
}

