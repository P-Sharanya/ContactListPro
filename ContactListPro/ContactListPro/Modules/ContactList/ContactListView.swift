import SwiftUI

struct ContactListView: View {
    @ObservedObject var presenter: ContactListPresenter
    
    var body: some View {
        NavigationView {
            List {
                ForEach(presenter.contacts) { contact in
                    Button(action: {
                        presenter.contactTapped(contact)
                    }) {
                        VStack(alignment: .leading) {
                            Text(contact.name).font(.headline)
                            Text(contact.phone).font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: presenter.delete)
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button(action: { presenter.addButtonTapped() }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            presenter.loadContacts()
        }
    }
}
