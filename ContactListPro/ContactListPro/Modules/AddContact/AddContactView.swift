import SwiftUI

struct AddContactView: View, AddContactViewProtocol {
  
    
    @StateObject var presenter: AddContactPresenter
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    
    @State private var nameInvalid = false
    @State private var phoneInvalid = false
    @State private var emailInvalid = false
    
    var body: some View {
        Form {
            Section(header: Text("Contact Information").font(.subheadline)) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 2) {
                        Image(systemName: "person")
                        Text("Name")
                        Text("*").foregroundColor(.red)
                    }.font(.headline)
                    TextField("Enter name", text: $name)
                        .textInputAutocapitalization(.words)
                        .padding(8)
                        .background(nameInvalid ? Color.red.opacity(0.2) : Color.clear)
                        .cornerRadius(6)
                }
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 2) {
                        Image(systemName: "phone")
                        Text("Phone")
                        Text("*").foregroundColor(.red)
                    }.font(.headline)
                    TextField("Enter phone number", text: $phone)
                        .keyboardType(.numberPad)
                        .padding(8)
                        .background(phoneInvalid ? Color.red.opacity(0.2) : Color.clear)
                        .cornerRadius(6)
                }
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 2) {
                        Image(systemName: "envelope")
                        Text("Email")
                        Text("*").foregroundColor(.red)
                    }.font(.headline)
                    TextField("Enter email address", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(8)
                        .background(emailInvalid ? Color.red.opacity(0.2) : Color.clear)
                        .cornerRadius(6)
                }
            }
            Section {
                Button(action: {
                    presenter.didTapSave(name: name, phone: phone, email: email)
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
                Button(action: {
                    presenter.didTapCancel()
                }) {
                    Text("Cancel")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle("Add Contact").font(.title2)
        .onAppear {
        }
        .alert(item: $presenter.activeAlert) { alert in
            switch alert {
            case .error(let message):
                return Alert(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .default(Text("OK"))
                )

            case .success(let message):
                return Alert(
                    title: Text("Success"),
                    message: Text(message),
                    dismissButton: .default(Text("OK"))
                )

            default:
                return Alert(title: Text(""))
            }
        }
    }

}


