//
//  LoginViewController.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import UIKit
import Foundation // StringPaths için

final class LoginViewController: UIViewController, NavigationView {
    
    // MARK: - Properties
    var presenter: ViewToPresenterLoginProtocol!
    private var loginView: LoginView {
        return view as! LoginView
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view = LoginView(self)
        presenter.viewDidLoad()
        setupTapGesture()
    }
    
    // MARK: - UI Setup
    private func setupTapGesture() {
        // Ekrana dokunarak klavyeyi kapatma
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @objc func loginButtonTapped() {
        // Klavyeyi kapat
        dismissKeyboard()
        
        let email = loginView.getEmail()
        let password = loginView.getPassword()
        presenter.loginButtonTapped(email: email, password: password)
    }
    
    @objc func forgotPasswordTapped() {
        presenter.forgotPasswordTapped()
    }
    
    @objc func signUpTapped() {
        presenter.signUpTapped()
    }
    
    @objc func appleLoginTapped() {
        // Klavyeyi kapat
        dismissKeyboard()
        
        presenter.loginWithAppleTapped()
    }
    
    @objc func googleLoginTapped() {
        // Klavyeyi kapat
        dismissKeyboard()
        
        presenter.loginWithGoogleTapped()
    }
}

// MARK: - PresenterToViewLoginProtocol Implementation
extension LoginViewController: PresenterToViewLoginProtocol {
    func showLoading() {
        loginView.showLoading()
    }
    
    func hideLoading() {
        loginView.hideLoading()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: StringPaths.Login.Alert.error.localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringPaths.Login.Alert.ok.localized, style: .default))
        present(alert, animated: true)
    }
    
    func navigateToHome(user: User) {
        // Kullanıcı bilgisiyle birlikte navigateToHome metodunu çağır
        presenter.router?.navigateToHome(from: self, user: user)
    }
    
    func showLoginSuccess(message: String) {
        let alert = UIAlertController(title: StringPaths.Login.Alert.success.localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringPaths.Login.Alert.ok.localized, style: .default))
        present(alert, animated: true)
    }
    
    func clearFields() {
        loginView.clearFields()
    }
    
    func setEmailValidationError(_ error: String?) {
        loginView.setEmailValidationError(error)
    }
    
    func setPasswordValidationError(_ error: String?) {
        loginView.setPasswordValidationError(error)
    }
}
