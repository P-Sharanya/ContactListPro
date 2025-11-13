import SwiftUI

struct ContactListView: View {
    @StateObject var presenter: ContactListPresenter
    @State private var contacts: [Contact] = []
    @State private var showEmptyMessage = true // initially show message

    var body: some View {
        VStack {
            if showEmptyMessage {
                Button( action: {
                    presenter.didTapAddContact()
                }){
                    Image(systemName: "plus")
                }
                Text("No contacts yet. Tap '+' to add new contact.")
        
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(contacts) { contact in
                    Button(action: {
                        presenter.didSelectContact(contact)
                    }) {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Text(contact.phone)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Contacts")
        .toolbar {
            Button(action: {
                presenter.didTapAddContact()
            }) {
                Image(systemName: "plus")
            }
        }
        .onAppear {
            presenter.view = self
            presenter.viewDidLoad()
        }
        .background(Color.white) // helps prevent black screen
    }
}

extension ContactListView: ContactListViewProtocol {
    func showContacts(_ contacts: [Contact]) {
        self.contacts = contacts
        self.showEmptyMessage = contacts.isEmpty
    }

    func showEmptyState() {
        self.contacts = []
        self.showEmptyMessage = true
    }
}
