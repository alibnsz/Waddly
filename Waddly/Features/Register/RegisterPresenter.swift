//
//  RegisterPresenter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation

// MARK: - Validation Constants
private enum ValidationConstants {
    static let minimumPasswordLength = 6
    static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let phoneRegEx = "^[+]?[0-9]{10,15}$"
}

final class RegisterPresenter: ViewToPresenterRegisterProtocol {
    
    // MARK: - Properties
    weak var view: PresenterToViewRegisterProtocol?
    var interactor: PresenterToInteractorRegisterProtocol?
    var router: PresenterToRouterRegisterProtocol?
    
    // MARK: - Initialization
    init(interactor: PresenterToInteractorRegisterProtocol, router: PresenterToRouterRegisterProtocol, view: PresenterToViewRegisterProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    // MARK: - ViewToPresenterRegisterProtocol Methods
    func register(
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        password: String,
        confirmPassword: String,
        role: Int,
        termsAccepted: Bool,
        privacyAccepted: Bool
    ) {
        // Reset all error messages
        clearAllErrors()
        
        // Validate form fields
        var isValid = true
        
        // First name validation
        if firstName.isEmpty {
            view?.showFirstNameError(StringPaths.Register.Error.firstNameEmpty.localized)
            isValid = false
        }
        
        // Last name validation
        if lastName.isEmpty {
            view?.showLastNameError(StringPaths.Register.Error.lastNameEmpty.localized)
            isValid = false
        }
        
        // Email validation
        if email.isEmpty {
            view?.showEmailError(StringPaths.Register.Error.emailEmpty.localized)
            isValid = false
        } else if !isValidEmail(email) {
            view?.showEmailError(StringPaths.Register.Error.emailInvalid.localized)
            isValid = false
        }
        
        // Phone validation
        if phone.isEmpty {
            view?.showPhoneError(StringPaths.Register.Error.phoneNumberEmpty.localized)
            isValid = false
        } else if !isValidPhoneNumber(phone) {
            view?.showPhoneError(StringPaths.Register.Error.phoneNumberInvalid.localized)
            isValid = false
        }
        
        // Password validation
        if password.isEmpty {
            view?.showPasswordError(StringPaths.Register.Error.passwordEmpty.localized)
            isValid = false
        } else if password.count < ValidationConstants.minimumPasswordLength {
            view?.showPasswordError(StringPaths.Register.Error.passwordTooShort.localized)
            isValid = false
        }
        
        // Confirm password validation
        if password != confirmPassword {
            view?.showConfirmPasswordError(StringPaths.Register.Error.passwordsDoNotMatch.localized)
            isValid = false
        }
        
        // Terms & Privacy validation
        if !termsAccepted || !privacyAccepted {
            view?.showAlert(
                title: StringPaths.Register.Alert.error.localized,
                message: !termsAccepted ? StringPaths.Register.Error.termsNotAccepted.localized : StringPaths.Register.Error.privacyNotAccepted.localized
            )
            isValid = false
        }
        
        // If all validations pass, call the interactor to register the user
        if isValid {
            view?.showLoading()
            interactor?.registerUser(
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                password: password,
                role: role
            )
        }
    }
    
    func goBack() {
        router?.navigateBack()
    }
    
    // MARK: - Helper Methods
    private func clearAllErrors() {
        view?.showFirstNameError(nil)
        view?.showLastNameError(nil)
        view?.showEmailError(nil)
        view?.showPhoneError(nil)
        view?.showPasswordError(nil)
        view?.showConfirmPasswordError(nil)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", ValidationConstants.emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPhoneNumber(_ phone: String) -> Bool {
        // Simple validation, can be enhanced based on requirements
        let phonePred = NSPredicate(format:"SELF MATCHES %@", ValidationConstants.phoneRegEx)
        return phonePred.evaluate(with: phone.replacingOccurrences(of: " ", with: ""))
    }
}

// MARK: - Interactor to Presenter
extension RegisterPresenter: InteractorToPresenterRegisterProtocol {
    func registerSuccess() {
        view?.hideLoading()
        view?.showAlert(
            title: StringPaths.Register.Alert.success.localized,
            message: StringPaths.Register.Alert.registerSuccess.localized
        )
        view?.clearForm()
        
        // Navigate to login after successful registration
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.router?.navigateToLogin()
        }
    }
    
    func registerFailure(error: Error) {
        view?.hideLoading()
        view?.showAlert(
            title: StringPaths.Register.Alert.error.localized,
            message: error.localizedDescription
        )
    }
}
