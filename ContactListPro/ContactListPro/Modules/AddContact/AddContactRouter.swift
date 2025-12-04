import UIKit
import SwiftUI

final class AddContactRouter: AddContactRouterProtocol {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
