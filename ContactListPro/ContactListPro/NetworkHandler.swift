import Foundation

final class NetworkHandler {
    func fetchContacts(completion: @escaping ([Contact]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            let contacts = ContactStorage.shared.getAllContacts()
            DispatchQueue.main.async {
                completion(contacts)
            }
        }
    }
}

