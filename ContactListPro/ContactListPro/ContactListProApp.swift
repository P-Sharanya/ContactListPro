import Foundation
import SwiftUI

@main
struct ContactListProApp: App {
    var body: some Scene {
        WindowGroup {
           
            RootViewControllerWrapper {
                AppCompositionRoot.createRootViewController()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
