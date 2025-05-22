//
//  LoginPresenter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation

final class LoginPresenter: ViewToPresenterLoginProtocol {

    // MARK: - Properties
    weak var view: PresenterToViewLoginProtocol?
    var interactor: PresenterToInteractorLoginProtocol?
    var router: PresenterToRouterLoginProtocol?

    // MARK: - Initialization
    init(interactor: PresenterToInteractorLoginProtocol, router: PresenterToRouterLoginProtocol, view: PresenterToViewLoginProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    // MARK: - Lifecycle Methods
    func viewDidLoad() {
        // View ilk yüklendiğinde yapılacak işlemler
        if let lastEmail = interactor?.getLastLoggedInEmail() {
            // Bu örnek için lastEmail'i kullanmıyoruz, gerçek uygulamada email alanına otomatik doldurabiliriz
        }
    }
    
    // MARK: - Validation
    func validateInput(email: String, password: String) -> Bool {
        var isValid = true
        
        // Email validation
        if email.isEmpty {
            view?.setEmailValidationError(StringPaths.Login.Error.emailEmpty.localized)
            isValid = false
        } else if !isValidEmail(email) {
            view?.setEmailValidationError(StringPaths.Login.Error.emailInvalid.localized)
            isValid = false
        } else {
            view?.setEmailValidationError(nil)
        }
        
        // Password validation
        if password.isEmpty {
            view?.setPasswordValidationError(StringPaths.Login.Error.passwordEmpty.localized)
            isValid = false
        } else if password.count < 6 {
            view?.setPasswordValidationError(StringPaths.Login.Error.passwordTooShort.localized)
            isValid = false
        } else {
            view?.setPasswordValidationError(nil)
        }
        
        return isValid
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // MARK: - Actions
    func loginButtonTapped(email: String, password: String) {
        // Input validation
        guard validateInput(email: email, password: password) else {
            return
        }
        
        view?.showLoading()
        interactor?.loginUser(email: email, password: password)
    }
    
    func forgotPasswordTapped() {
        router?.navigateToForgotPassword(from: view)
    }
    
    func signUpTapped() {
        router?.navigateToSignUp(from: view)
    }
    
    func loginWithAppleTapped() {
        view?.showLoading()
        interactor?.loginWithApple()
    }
    
    func loginWithGoogleTapped() {
        view?.showLoading()
        interactor?.loginWithGoogle()
    }
}

// MARK: - Interactor to Presenter
extension LoginPresenter: InteractorToPresenterLoginProtocol {
    func loginSuccess(user: User) {
        view?.hideLoading()
        view?.showLoginSuccess(message: StringPaths.Login.Alert.welcome.localized(arguments: user.displayName ?? user.email))
        view?.clearFields()
        view?.navigateToHome(user: user)
    }
    
    func loginFailure(error: String) {
        view?.hideLoading()
        view?.showError(message: error)
    }
}
