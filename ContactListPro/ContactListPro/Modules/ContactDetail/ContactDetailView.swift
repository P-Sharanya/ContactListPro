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
        VStack {
            if isEditing {
                editView
            } else {
                detailView
            }
        }
        .navigationTitle(isEditing ? "Edit Contact" : "Contact Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                if !presenter.contact.isFromAPI {
                    if isEditing {
                    Button("Cancel") {
                        isEditing = false
                    }
                } else {
                    Button("Edit") {
                        name = presenter.contact.name
                        phone = presenter.contact.phone
                        email = presenter.contact.email
                        isEditing = true
                    }
                }
            }
            }
        }
        .alert(alertMessage, isPresented: $showAlert) {
            if isSuccessAlert {
                Button("OK") { isEditing = false }
            } else {
                Button("OK", role: .cancel) {}
            }
        }
        Group{
            if !presenter.isRemote && !isEditing {
                VStack {
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
}

extension ContactDetailView {

    // MARK: - Detail View
    private var detailView: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                infoRow(title: "Name", value: presenter.contact.name)
                infoRow(title: "Phone", value: presenter.contact.phone)
                infoRow(title: "Email", value: presenter.contact.email)
            }
            .padding(.horizontal)

            Spacer()

         
        }
    }

    private func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.body)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity,alignment: .leading)

    }

    // MARK: - Edit View
    private var editView: some View {
        Form {
            Section(header: Text("Contact Information")) {

                labeledField("Name", text: $name)
                labeledField("Phone", text: $phone)
                    .keyboardType(.numberPad)

                labeledField("Email", text: $email)
                    .keyboardType(.emailAddress)
            }

            Section {
                Button {
                    presenter.didTapSaveEdit(name: name, phone: phone, email: email)
                } label: {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private func labeledField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField(label, text: text)
                .padding(8)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
        }
        .padding(.vertical, 4)
    }

    // MARK: - Protocol
    func showAlert(message: String, success: Bool = false) {
        alertMessage = message
        isSuccessAlert = success
        showAlert = true
    }
}
