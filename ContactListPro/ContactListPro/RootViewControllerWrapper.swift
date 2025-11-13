
import Foundation
import SwiftUI
import UIKit

struct RootViewControllerWrapper: UIViewControllerRepresentable {
    let builder: () -> UIViewController

    init(_ builder: @escaping () -> UIViewController) {
        self.builder = builder
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = builder()
        vc.view.backgroundColor = .white // prevent black screen
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
