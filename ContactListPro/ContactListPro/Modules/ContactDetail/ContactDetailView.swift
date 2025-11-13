import SwiftUI

struct ContactDetailView: View, ContactDetailViewProtocol {
    @StateObject private var presenter: ContactDetailPresenter
    @State private var showDeleteConfirmation = false
    @State private var isEditing = false

    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""


    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccessAlert = false

    init(presenter: ContactDetailPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isEditing {
                Form {
                    Section(header: Text("Edit Contact")) {
                        TextField("Name", text: $name)
                        TextField("Phone", text: $phone)
                            .keyboardType(.numberPad)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                    }

                    Section {
                        Button("Save Changes") {
                            presenter.didTapSaveEdit(name: name, phone: phone, email: email)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }

            } else {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Name:").bold()
                        Spacer()
                        Text(presenter.contact.name)
                    }
                    HStack {
                        Text("Phone:").bold()
                        Spacer()
                        Text(presenter.contact.phone)
                    }
                    HStack {
                        Text("Email:").bold()
                        Spacer()
                        Text(presenter.contact.email)
                    }
                }
                .padding(.horizontal)

                Spacer()

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Text("Delete Contact")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Contact" : "Contact Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !isEditing {
                    Button("Edit") {
                        name = presenter.contact.name
                        phone = presenter.contact.phone
                        email = presenter.contact.email
                        isEditing = true
                    }
                } else {
                    Button("Cancel") {
                        isEditing = false
                    }
                }
            }
        }
        .alert(alertMessage, isPresented: $showAlert) {
            if isSuccessAlert {
                Button("OK") {
                    isEditing = false
                }
            } else {
                Button("OK", role: .cancel) { }
            }
        }
        .alert("Are you sure you want to delete this contact?",
               isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                presenter.didTapDelete()
            }
        }
        .onAppear {
            presenter.view = self
        }
    }

    // MARK: - ContactDetailViewProtocol
    func showAlert(message: String, success: Bool = false) {
        alertMessage = message
        isSuccessAlert = success
        showAlert = true
    }
}

