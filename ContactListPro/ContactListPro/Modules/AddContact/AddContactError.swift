import Foundation

enum AddContactValidationError: Error, LocalizedError {
    case emptyName
    case emptyPhone
    case emptyEmail
    case invalidPhone
    case invalidEmail

    var errorDescription: String? {
        switch self {
        case .emptyName:
            return "Name is required."
        case .emptyPhone:
            return "Phone number is required."
        case .emptyEmail:
            return "Email address is required."
        case .invalidPhone:
            return "Phone number must contain exactly 10 digits."
        case .invalidEmail:
            return "Please enter a valid email address."
        }
    }
}
