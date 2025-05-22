//
//  RegisterView.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import UIKit
import SnapKit

final class RegisterView: BaseView<RegisterViewController>, UITextFieldDelegate {
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(ImagePaths.systemIcon(named: ImagePaths.Auth.backArrow), for: .normal)
        button.tintColor = .appPrimary
        button.addTarget(controller, action: #selector(RegisterViewController.backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(style: .header, text: StringPaths.Register.View.title.localized)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var firstNameInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Register.View.firstName.localized,
            placeholder: StringPaths.Register.View.firstNamePlaceholder.localized
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.person))
        return inputField
    }()
    
    private lazy var lastNameInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Register.View.lastName.localized,
            placeholder: StringPaths.Register.View.lastNamePlaceholder.localized
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.person))
        return inputField
    }()
    
    private lazy var emailInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Register.View.email.localized,
            placeholder: StringPaths.Register.View.emailPlaceholder.localized
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.email))
        inputField.setKeyboardType(.emailAddress)
        inputField.setAutocapitalizationType(.none)
        inputField.setAutocorrectionType(.no)
        return inputField
    }()
    
    private lazy var phoneInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Register.View.phoneNumber.localized,
            placeholder: StringPaths.Register.View.phoneNumberPlaceholder.localized
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.phone))
        inputField.setKeyboardType(.phonePad)
        return inputField
    }()
    
    private lazy var passwordInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Register.View.password.localized,
            placeholder: StringPaths.Register.View.passwordPlaceholder.localized,
            isSecure: true
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.password))
        inputField.setAutocapitalizationType(.none)
        inputField.setAutocorrectionType(.no)
        return inputField
    }()
    
    private lazy var confirmPasswordInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Register.View.confirmPassword.localized,
            placeholder: StringPaths.Register.View.confirmPasswordPlaceholder.localized,
            isSecure: true
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.password))
        inputField.setAutocapitalizationType(.none)
        inputField.setAutocorrectionType(.no)
        return inputField
    }()
    
    private lazy var roleSelectionLabel: CustomLabel = {
        let label = CustomLabel(style: .bodyLight)
        return label
    }()
    
    private lazy var roleSegmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: [
            StringPaths.Register.View.roleParent.localized,
            StringPaths.Register.View.roleTeacher.localized
        ])
        segmentedControl.onValueChanged = { [weak self] _ in
            // Handle role selection change
        }
        return segmentedControl
    }()
    
    private lazy var termsCheckbox: CustomCheckbox = {
        let checkbox = CustomCheckbox(title: StringPaths.Register.View.termsCheckbox.localized)
        return checkbox
    }()
    
    private lazy var privacyCheckbox: CustomCheckbox = {
        let checkbox = CustomCheckbox(title: StringPaths.Register.View.privacyCheckbox.localized)
        return checkbox
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton()
        button.configure(with: .primary, title: StringPaths.Register.View.register.localized)
        button.addTarget(controller, action: #selector(RegisterViewController.registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .appPrimary
        return indicator
    }()
    
    // MARK: - View Setup
    override func setupView() {
        super.setupView()
        backgroundColor = .appBackground
        setupLayout()
        setupConstraints()
        setupKeyboardNotifications()
    }

    private func setupLayout() {
        addSubview(navigationBar)
        navigationBar.addSubview(backButton)
        navigationBar.addSubview(titleLabel)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(firstNameInputField)
        contentView.addSubview(lastNameInputField)
        contentView.addSubview(emailInputField)
        contentView.addSubview(phoneInputField)
        contentView.addSubview(passwordInputField)
        contentView.addSubview(confirmPasswordInputField)
        contentView.addSubview(roleSegmentedControl)
        contentView.addSubview(termsCheckbox)
        contentView.addSubview(privacyCheckbox)
        contentView.addSubview(registerButton)
        
        addSubview(activityIndicator)
        
        // TextField delegate ve return key type ayarları
        firstNameInputField.textField.delegate = self
        lastNameInputField.textField.delegate = self
        emailInputField.textField.delegate = self
        phoneInputField.textField.delegate = self
        passwordInputField.textField.delegate = self
        confirmPasswordInputField.textField.delegate = self
        
        // Her alan için return key türünü ayarla
        firstNameInputField.textField.returnKeyType = .next
        lastNameInputField.textField.returnKeyType = .next
        emailInputField.textField.returnKeyType = .next
        phoneInputField.textField.returnKeyType = .next
        passwordInputField.textField.returnKeyType = .next
        confirmPasswordInputField.textField.returnKeyType = .done
    }
    
    func setupConstraints() {
        // Navigation Bar
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // ScrollView and ContentView
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            // Height will be determined by content
        }
        
        // Form Fields
        firstNameInputField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.Metrics.standardDynamicSpace)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        lastNameInputField.snp.makeConstraints { make in
            make.top.equalTo(firstNameInputField.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 0.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        emailInputField.snp.makeConstraints { make in
            make.top.equalTo(lastNameInputField.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 0.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        phoneInputField.snp.makeConstraints { make in
            make.top.equalTo(emailInputField.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 0.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        passwordInputField.snp.makeConstraints { make in
            make.top.equalTo(phoneInputField.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 0.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        confirmPasswordInputField.snp.makeConstraints { make in
            make.top.equalTo(passwordInputField.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 0.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        roleSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordInputField.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
            make.height.equalTo(UIConstants.Metrics.buttonHeight)
        }
        
        termsCheckbox.snp.makeConstraints { make in
            make.top.equalTo(roleSegmentedControl.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace)
            make.leading.trailing.equalTo(firstNameInputField)
            make.height.greaterThanOrEqualTo(30) // Minimum yükseklik
        }
        
        privacyCheckbox.snp.makeConstraints { make in
            make.top.equalTo(termsCheckbox.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace)
            make.leading.trailing.equalTo(firstNameInputField)
            make.height.greaterThanOrEqualTo(30) // Minimum yükseklik
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(privacyCheckbox.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 1.2)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
            make.height.equalTo(UIConstants.Metrics.buttonHeight)
            make.bottom.equalToSuperview().offset(-UIConstants.Metrics.standardDynamicSpace) // ContentView'in altı için boşluk bırakın
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.scrollIndicatorInsets.bottom = keyboardSize.height
            
            // Scroll to active field
            if let activeTextField = findActiveTextField() {
                let rect = activeTextField.convert(activeTextField.bounds, to: scrollView)
                scrollView.scrollRectToVisible(rect, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }
    
    private func findActiveTextField() -> UITextField? {
        if firstNameInputField.textField.isFirstResponder {
            return firstNameInputField.textField
        } else if lastNameInputField.textField.isFirstResponder {
            return lastNameInputField.textField
        } else if emailInputField.textField.isFirstResponder {
            return emailInputField.textField
        } else if phoneInputField.textField.isFirstResponder {
            return phoneInputField.textField
        } else if passwordInputField.textField.isFirstResponder {
            return passwordInputField.textField
        } else if confirmPasswordInputField.textField.isFirstResponder {
            return confirmPasswordInputField.textField
        }
        return nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Methods
    func showLoading() {
        activityIndicator.startAnimating()
        isUserInteractionEnabled = false
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        isUserInteractionEnabled = true
    }
    
    func getFirstName() -> String {
        return firstNameInputField.getText()
    }
    
    func getLastName() -> String {
        return lastNameInputField.getText()
    }
    
    func getEmail() -> String {
        return emailInputField.getText()
    }
    
    func getPhoneNumber() -> String {
        return phoneInputField.getText()
    }
    
    func getPassword() -> String {
        return passwordInputField.getText()
    }
    
    func getConfirmPassword() -> String {
        return confirmPasswordInputField.getText()
    }
    
    func getSelectedRole() -> Int {
        return roleSegmentedControl.selectedIndex
    }
    
    func isTermsAccepted() -> Bool {
        return termsCheckbox.isChecked
    }
    
    func isPrivacyAccepted() -> Bool {
        return privacyCheckbox.isChecked
    }
    
    func clearFields() {
        firstNameInputField.clearText()
        lastNameInputField.clearText()
        emailInputField.clearText()
        phoneInputField.clearText()
        passwordInputField.clearText()
        confirmPasswordInputField.clearText()
        roleSegmentedControl.setSelectedIndex(0)
        termsCheckbox.setChecked(false)
        privacyCheckbox.setChecked(false)
    }
    
    func setFirstNameError(_ error: String?) {
        firstNameInputField.setError(error)
    }
    
    func setLastNameError(_ error: String?) {
        lastNameInputField.setError(error)
    }
    
    func setEmailError(_ error: String?) {
        emailInputField.setError(error)
    }
    
    func setPhoneNumberError(_ error: String?) {
        phoneInputField.setError(error)
    }
    
    func setPasswordError(_ error: String?) {
        passwordInputField.setError(error)
    }
    
    func setConfirmPasswordError(_ error: String?) {
        confirmPasswordInputField.setError(error)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameInputField.textField {
            lastNameInputField.textField.becomeFirstResponder()
        } else if textField == lastNameInputField.textField {
            emailInputField.textField.becomeFirstResponder()
        } else if textField == emailInputField.textField {
            phoneInputField.textField.becomeFirstResponder()
        } else if textField == phoneInputField.textField {
            passwordInputField.textField.becomeFirstResponder()
        } else if textField == passwordInputField.textField {
            confirmPasswordInputField.textField.becomeFirstResponder()
        } else if textField == confirmPasswordInputField.textField {
            // Son alandan sonra klavyeyi kapat
            textField.resignFirstResponder()
            // Opsiyonel: Kayıt butonunu tetikle
            controller.registerButtonTapped()
        }
        return true
    }
}

