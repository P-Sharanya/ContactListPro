
#  ContactListPro

**ContactListPro** is a SwiftUI-based iOS application that follows the **VIPER architecture pattern** for UI, UIKit hosting controllers for navigation, VIPER architecture for modularity, UserDefaults for persistent storage, and URLSession for fetching API contacts.

The project uses **modular architecture** for clear separation of concerns and easy scalability.

`Modules` define separate VIPER components for each screen (List, Add, Detail).

`Storage` uses **UserDefaults** through the `ContactStorage` class to persist user data locally.

`AppCompositionRoot` builds and injects dependencies, setting up the app’s root navigation controller.

`NetworkHandler` simulates fetching contacts asynchronously.

`AppDelegate` sets up the initial UI and application lifecycle, loading the root module.

---

##  Screen 1 – Contact List


The **Contact List** screen displays merged local and API contacts in a clean SwiftUI list format. If no contacts are available,it shows API contacts which are stored locally. Users can tap the **“+”** icon to add new contacts or select an existing contact to view details.


<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 13 51 13" src="https://github.com/user-attachments/assets/16a0ad89-f00a-46a8-9d9e-bd080595a4cc" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 16 14 05" src="https://github.com/user-attachments/assets/313c153c-a607-4533-8786-ad7dea08185e" />


**VIPER flow :**

1. `ContactListBuilder` connects all components and injects dependencies into the module.
2. `ContactListView` displays the list and handles user interactions (like add or select).
3. `ContactListPresenter` asks interactor for local/API contacts using `NetworkHandler` & `ContactStorage` and merges results and updates `ContactListView`.
4. `ContactListInteractor` fetches API contacts via URLSession, and local contacts directly from `ContactStorage`.
5. `ContactListRouter` manages navigation to `AddContactBuilder` for adding new contact or `ContactDetailBuilder` for viewing or editing the contact.

---

##  Screen 2 – Add Contact

The **Add Contact** screen allows users to create new contacts by entering name, phone, and email information with validation handled in the presenter. The form uses SwiftUI with alert messaging when invalid inputs entered. When saved, the new contact is stored locally using `UserDefaults`, and the app returns to the main contact list and the list refreshes using a callback.

<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 16 21 27" src="https://github.com/user-attachments/assets/b274f63a-cfe5-4ffe-9ac7-ef1d7a7bea3e" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 13 52 13" src="https://github.com/user-attachments/assets/9fe95314-2229-48d7-8e58-1155fcfceeba" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 13 52 24" src="https://github.com/user-attachments/assets/84aa2256-14f2-4b8e-939a-d62e75faac77" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 13 52 42" src="https://github.com/user-attachments/assets/4720664b-0f8e-426c-9594-aa8cefaf2f30" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 15 25 08" src="https://github.com/user-attachments/assets/503ff5ad-56c6-4235-8fce-0429ff499817" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 15 31 24" src="https://github.com/user-attachments/assets/6ed1ee86-a95e-4e7f-b8a1-2778ec84f9ce" />

**VIPER flow :**

1. `AddContactBuilder` constructs the view, presenter, interactor, and router.
2. `AddContactView` collects user input, shows validation errors received from the presenter and forwards actions to the presenter.
3. `AddContactPresenter` performs field validation and passes valid data to the interactor.
4. `AddContactInteractor` creates a new `Contact` and saves it via `ContactStorage`.
5. `AddContactRouter` handles dismissing and triggers list refresh in `ContactListPresenter`.
t.


---

##  Screen 3 – Contact Detail


The **Contact Detail** screen shows detailed information about a selected contact, including name, phone, and email. Users can edit details or delete the local and API contacts. The screen toggles between read and edit modes through SwiftUI.  Any update or deletion is reflected immediately in the list through persistent storage managed by `ContactStorage`.

<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 15 51 53" src="https://github.com/user-attachments/assets/29b634be-e0e6-4161-8605-76aeca85604d" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 16 14 32" src="https://github.com/user-attachments/assets/4b0da6ad-9734-4c97-babd-179fed1e619a" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 16 14 35" src="https://github.com/user-attachments/assets/fb78d4ee-9c57-4833-a8ae-895bc3a67c8d" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 15 54 02" src="https://github.com/user-attachments/assets/f31cb3f8-8fed-46e0-a6a5-6bec807715b9" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 16 11 36" src="https://github.com/user-attachments/assets/483f1deb-26c9-44fe-8af2-0f74de6f2774" />
<img width="200" alt="Simulator Screen Shot - iPhone 14 Pro - 2025-11-28 at 16 11 44" src="https://github.com/user-attachments/assets/f7e52aa4-e979-4581-bf7d-730ae0a95114" />



**VIPER flow :**

1. `ContactDetailBuilder` creates the module and determines if the contact is local or API-based.
2. `ContactDetailView` displays or edits contact fields.
3. `ContactDetailPresenter` validates edits or triggers deletion.
4. `ContactDetailInteractor` updates or removes data via ContactStorage.
5. After successful delete/update, presenter triggers UI alerts and callback refresh.
6. `ContactDetailRouter` navigates back after operations.

---

**Tech Summary**

* **Framework:** SwiftUI + UIKit integration
* **Architecture:** VIPER
* **Local Storage:** UserDefaults (via `ContactStorage`)
* **Language:** Swift
* **Navigation:** `UINavigationController` through hosting controllers
* **Data Handling:** One-time API fetch with `NetworkHandler` using URLSession and async calls

---

**Key Features**

* Entire UI is built using SwiftUI, modularized with VIPER.
* Modular VIPER structure for scalability
* Local persistence using UserDefaults
* Clean separation between logic and UI
* Add, Edit, Delete, and View contact functionalities
* API contacts come from "jsonplaceholder.typicode.com"
* Navigation uses UIKit UINavigationController wrapped in hosting controllers.
---
