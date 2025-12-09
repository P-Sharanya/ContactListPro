import SwiftUI

struct ContactListView: View {
    
    @StateObject var presenter: ContactListPresenter
    @State private var contacts: [Contact] = []
   
    
    init(presenter: ContactListPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        VStack {
            switch presenter.loadingState {
            case .idle:
                IdleView()
            case .loading(let placeholders):
                LoadingView(placeholders: placeholders)
            case .loaded:
                LoadedView(contacts: presenter.contacts, presenter: presenter)
            case .error(let message, let showRetry):
                ErrorView(message: message, showRetry: showRetry) {
                    presenter.viewDidLoad()
                }
                
            }
        }
        .navigationTitle(presenter.isRemoteList ? "API Contacts" : "Contacts")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if presenter.isRemoteList {
                    Button("Contacts") { presenter.loadLocalContacts() }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if !presenter.isRemoteList {
                    Button { presenter.didTapAddContact() } label: { Image(systemName: "plus") }
                }
            }
        }
        .onAppear {
            presenter.viewDidLoad()
        }
        .alert(item: $presenter.activeAlert) { alert in
            switch alert {
            case .success(let msg):
                return Alert(
                    title: Text("Success"),
                    message: Text(msg),
                    dismissButton: .default(Text("OK"))
                )
            case .error(let msg):
                return Alert(
                    title: Text("Error"),
                    message: Text(msg),
                    dismissButton: .default(Text("OK"))
                )
            case .confirmDelete(let contact):

                return Alert(
                    title: Text("Confirm"),
                    message: Text("Do you want to delete this contact?"),
                    primaryButton: .destructive(Text("Delete")) {
                        presenter.didConfirmDelete(contact)
                    },
                    secondaryButton: .cancel()
                    
                )
            }
        }
                        
        }
    }
    //MARK: - Subviews
    
    struct IdleView: View{
        var body: some View{
            VStack {
                Spacer()
                ProgressView("Loading...")
                    .scaleEffect(1.5)
                    .padding()
                Spacer()
            }
        }
    }
    struct LoadingView: View {
        let placeholders: [Contact]
        
        var body: some View{
            List(placeholders) { placeholder in
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(placeholder.name)
                            .font(.headline)
                            .redacted(reason: .placeholder)
                        Text(placeholder.phone)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .redacted(reason: .placeholder)
                    }
                    Spacer()
                    Text(placeholder.email)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .redacted(reason: .placeholder)
                }.padding(.vertical, 8)
            }.listStyle(PlainListStyle())
        }
    }
    struct LoadedView: View {
        let contacts: [Contact]
        let presenter: ContactListPresenter
        
        var body: some View{
            if contacts.isEmpty {
                VStack {
                    Spacer()
                    Text("No contacts found")
                        .foregroundColor(.gray)
                    Spacer()
                }
                
            } else {
                
                List(contacts, id: \.id) { contact in
                    Button(action: { presenter.didSelectContact(contact) }) {
                        HStack {
                            ZStack{
                                let color = fixedColor(for: contact)
                                Circle()
                                    .fill(color.opacity(0.15))
                                    .frame(width: 42, height: 42)
                                
                            Text(String(contact.name.prefix(1)))
                                .font(.title3)
                                .foregroundColor(color)
                        }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(contact.name).font(.headline)
                                Text(contact.email).font(.caption).foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(contact.phone).foregroundColor(.secondary)
                        }.padding(.vertical, 8)
                    }
                    .swipeActions {
                        Button {
                            presenter.requestDelete(contact)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }.listStyle(PlainListStyle())
            }
        }
    }
    struct ErrorView: View{
        let message: String
        let showRetry: Bool
        let retryAction: () -> Void
        
        var body: some View{
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.orange)
                Text(message).foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                if showRetry {
                    Button("Retry", action: retryAction)
                        .padding(.top, 4)
                }
                Spacer()
            }
        }
    }
private func fixedColor(for contact: Contact) -> Color {
    let colors: [Color] = [
        .blue, .green, .orange, .purple, .pink, .red, .teal, .indigo,.yellow,.brown,.black
    ]
    let hash = abs(contact.id.uuidString.hashValue)
    return colors[hash % colors.count]
}

