# ContactListPro

I created this iOS project using SwiftUI and follows the VIPER architecture pattern for the Contact List. The app uses UserDefaults for local storage to save and retrieve contact details persistently. This structure keeps logic centralized, improves testability, and makes the flow modular and easy to maintain.

Modules: Each feature (like ContactList, ContactDetail, AddContact) is a self-contained module to separate logic, UI, and navigation.

App: The ContactListProApp.swift file is the entry point that initializes and displays the main module (ContactListView).

Storage: The ContactStorage.swift file manages saving, retrieving, and deleting contact data using UserDefaults, keeping persistence logic separate from UI.

Entities: The Contact.swift file defines the contact data model (id, name, phone, email) used throughout the app, ensuring consistent data structure.

Screen 1 — Contact List Screen

The Contact List screen displays all stored contacts fetched from UserDefaults. It allows adding, selecting, or deleting contacts. The screen uses a SwiftUI List showing names and phone numbers, with an “Add”(+) button in the navigation bar for creating new contacts.

 VIPER Flow :

•	ContactListRouter builds and connects ContactListView, ContactListPresenter, ContactListInteractor, and ContactEntity.

•	ContactListView appears and calls ContactListPresenter to fetch data.


•	ContactListPresenter communicates with ContactListInteractor to get data from ContactStorage.

•	ContactListInteractor retrieves stored contacts from UserDefaults and passes them to ContactListPresenter, which updates ContactListView with the formatted list.


•	Selecting or adding contacts triggers navigation through ContactListRouter.

Screen 2 — Add Contact Screen

The Add Contact screen is a SwiftUI form for entering new contact details (name, phone, email). It doesn’t have a separate VIPER module; it uses logic from the ContactListInteractor for saving data and communicates back through the ContactListPresenter to refresh the list.

Working:

•	AddContactView collects user input and creates a new ContactEntity.

•	It calls ContactListInteractor to save the new contact into UserDefaults via ContactStorage.


•	Once saved, the ContactListPresenter is informed to refresh the list.

•	The screen dismisses and returns to ContactListView, showing the updated contacts.

Screen 3 — Contact Detail Screen

The Contact Detail screen displays a single contact’s full information and provides edit and delete options. It relies on the ContactList VIPER structure to manage updates and deletions, ensuring all data modifications go through the same Interactor and Presenter layers.

Working:

•	ContactListView passes the selected ContactEntity to ContactDetailView.

•	ContactDetailView displays the data and, if edited or deleted, communicates with ContactListInteractor.

•	ContactListInteractor updates or removes the record in UserDefaults using ContactStorage.


•	The ContactListPresenter refreshes ContactListView with the latest data when returning.


