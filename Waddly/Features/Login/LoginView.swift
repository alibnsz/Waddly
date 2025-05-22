//
//  LoginView.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import UIKit
import SnapKit
import Foundation

final class LoginView: BaseView<LoginViewController>, UITextFieldDelegate {
    
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
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImagePaths.image(named: ImagePaths.Logos.appLogo)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emailInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Login.View.email.localized,
            placeholder: StringPaths.Login.View.emailPlaceholder.localized
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.email))
        inputField.setKeyboardType(.emailAddress)
        inputField.setAutocapitalizationType(.none)
        inputField.setAutocorrectionType(.no)
        return inputField
    }()
    
    private lazy var emailErrorLabel: CustomLabel = {
        let label = CustomLabel(style: .error)
        label.isHidden = true
        return label
    }()
    
    private lazy var passwordInputField: CustomInputField = {
        let inputField = CustomInputField(
            title: StringPaths.Login.View.password.localized,
            placeholder: StringPaths.Login.View.passwordPlaceholder.localized,
            isSecure: true
        )
        inputField.setupIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.password))
        inputField.setAutocapitalizationType(.none)
        inputField.setAutocorrectionType(.no)
        return inputField
    }()
    
    private lazy var passwordErrorLabel: CustomLabel = {
        let label = CustomLabel(style: .error)
        label.isHidden = true
        return label
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringPaths.Login.View.forgotPassword.localized, for: .normal)
        button.titleLabel?.font = UIConstants.Fonts.smallFont
        button.setTitleColor(.appTextSecondary, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(controller, action: #selector(LoginViewController.forgotPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton()
        button.configure(with: .primary, title: StringPaths.Login.View.login.localized)
        button.addTarget(controller, action: #selector(LoginViewController.loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        
        let leftLine = UIView()
        leftLine.backgroundColor = .appBorder
        
        let rightLine = UIView()
        rightLine.backgroundColor = .appBorder
        
        let orLabel = CustomLabel(style: .caption, text: StringPaths.Login.View.or.localized)
        orLabel.textAlignment = .center
        
        view.addSubview(leftLine)
        view.addSubview(orLabel)
        view.addSubview(rightLine)
        
        leftLine.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        orLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(60)
        }
        
        rightLine.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        return view
    }()
    
    private lazy var appleLoginButton: CustomButton = {
        let button = CustomButton()
        button.configure(with: .primary, title: StringPaths.Login.View.continueWithApple.localized)
        button.addIcon(image: ImagePaths.systemIcon(named: ImagePaths.Auth.appleLogo), tintColor: .white)
        button.addTarget(controller, action: #selector(LoginViewController.appleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleLoginButton: CustomButton = {
        let button = CustomButton()
        button.configure(with: .secondary, title: StringPaths.Login.View.continueWithGoogle.localized)
        button.addIcon(image: ImagePaths.image(named: ImagePaths.Auth.googleIcon) ?? ImagePaths.systemIcon(named: "g.circle"))
        button.addTarget(controller, action: #selector(LoginViewController.googleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var noAccountLabel: CustomLabel = {
        let label = CustomLabel(style: .caption, text: StringPaths.Login.View.noAccount.localized)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringPaths.Login.View.signUp.localized, for: .normal)
        button.titleLabel?.font = UIConstants.Fonts.smallFont
        button.setTitleColor(.appAccent, for: .normal)
        button.addTarget(controller, action: #selector(LoginViewController.signUpTapped), for: .touchUpInside)
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(emailInputField)
        contentView.addSubview(passwordInputField)
        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(loginButton)
        contentView.addSubview(dividerView)
        contentView.addSubview(appleLoginButton)
        contentView.addSubview(googleLoginButton)
        contentView.addSubview(noAccountLabel)
        contentView.addSubview(signUpButton)
        
        addSubview(activityIndicator)
        
        // TextField delegate ve return key type ayarları
        emailInputField.textField.delegate = self
        passwordInputField.textField.delegate = self
        
        emailInputField.textField.returnKeyType = .next
        passwordInputField.textField.returnKeyType = .done
    }
    
    func setupConstraints() {
        // Ekranı safeArea'dan başlatarak daha iyi bir görünüm elde edelim
        let safeArea = safeAreaLayoutGuide
        
        // ScrollView ve ContentView için constraintler
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            // Yüksekliği belirtmeyin - içerik boyutuna göre otomatik ayarlanacak
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIConstants.Metrics.topSpace)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        emailInputField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 1.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        passwordInputField.snp.makeConstraints { make in
            make.top.equalTo(emailInputField.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 0.5)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordInputField.textField.snp.bottom).offset(UIConstants.Metrics.microSpacing)
            make.trailing.equalTo(passwordInputField.snp.trailing)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
            make.height.equalTo(UIConstants.Metrics.buttonHeight)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
            make.height.equalTo(UIConstants.Metrics.dividerHeight)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
            make.height.equalTo(UIConstants.Metrics.buttonHeight)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 0.8)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.Metrics.standardWidth)
            make.height.equalTo(UIConstants.Metrics.buttonHeight)
        }
        
        noAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(googleLoginButton.snp.bottom).offset(UIConstants.Metrics.standardDynamicSpace * 1.5)
            make.trailing.equalTo(self.snp.centerX).offset(-4)
            make.bottom.equalToSuperview().offset(-UIConstants.Metrics.standardDynamicSpace) // ContentView'in altı için boşluk
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(4)
            make.centerY.equalTo(noAccountLabel.snp.centerY)
            make.bottom.equalToSuperview().offset(-UIConstants.Metrics.standardDynamicSpace) // ContentView'in altı için boşluk
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
            
            // Aktif text field'a scroll yapın
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
        if emailInputField.textField.isFirstResponder {
            return emailInputField.textField
        } else if passwordInputField.textField.isFirstResponder {
            return passwordInputField.textField
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
    
    func getEmail() -> String {
        return emailInputField.getText()
    }
    
    func getPassword() -> String {
        return passwordInputField.getText()
    }
    
    func clearFields() {
        emailInputField.clearText()
        passwordInputField.clearText()
        setEmailValidationError(nil)
        setPasswordValidationError(nil)
    }
    
    func setEmailValidationError(_ error: String?) {
        emailInputField.setError(error)
    }
    
    func setPasswordValidationError(_ error: String?) {
        passwordInputField.setError(error)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailInputField.textField {
            // Email alanından sonra password alanına geç
            passwordInputField.textField.becomeFirstResponder()
        } else if textField == passwordInputField.textField {
            // Password alanından sonra klavyeyi kapat
            textField.resignFirstResponder()
            // Opsiyonel: Login butonunu tetikle
            controller.loginButtonTapped()
        }
        return true
    }
}

