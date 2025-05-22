//
//  RegisterViewController.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import UIKit

final class RegisterViewController: UIViewController, NavigationView {
    
    // MARK: - Properties
    var presenter: ViewToPresenterRegisterProtocol!
    private var registerView: RegisterView {
        return view as! RegisterView
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view = RegisterView(self)
        view.backgroundColor = .appBackground
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
    @objc func backButtonTapped() {
        dismissKeyboard()
        presenter.goBack()
    }
    
    @objc func registerButtonTapped() {
        dismissKeyboard()
        
        let firstName = registerView.getFirstName()
        let lastName = registerView.getLastName()
        let email = registerView.getEmail()
        let phone = registerView.getPhoneNumber()
        let password = registerView.getPassword()
        let confirmPassword = registerView.getConfirmPassword()
        let role = registerView.getSelectedRole()
        let termsAccepted = registerView.isTermsAccepted()
        let privacyAccepted = registerView.isPrivacyAccepted()
        
        presenter.register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            password: password,
            confirmPassword: confirmPassword,
            role: role,
            termsAccepted: termsAccepted,
            privacyAccepted: privacyAccepted
        )
    }
}

extension RegisterViewController: PresenterToViewRegisterProtocol {
    func showLoading() {
        registerView.showLoading()
    }
    
    func hideLoading() {
        registerView.hideLoading()
    }
    
    func showFirstNameError(_ error: String?) {
        registerView.setFirstNameError(error)
    }
    
    func showLastNameError(_ error: String?) {
        registerView.setLastNameError(error)
    }
    
    func showEmailError(_ error: String?) {
        registerView.setEmailError(error)
    }
    
    func showPhoneError(_ error: String?) {
        registerView.setPhoneNumberError(error)
    }
    
    func showPasswordError(_ error: String?) {
        registerView.setPasswordError(error)
    }
    
    func showConfirmPasswordError(_ error: String?) {
        registerView.setConfirmPasswordError(error)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringPaths.Register.Alert.ok.localized, style: .default))
        present(alert, animated: true)
    }
    
    func clearForm() {
        registerView.clearFields()
    }
}
