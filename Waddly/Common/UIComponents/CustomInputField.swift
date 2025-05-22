//
//  CustomInputField.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit
import SnapKit

class CustomInputField: UIView {
    
    // MARK: - Properties
    private(set) lazy var titleLabel: CustomLabel = {
        return CustomLabel(style: .bodyLight)
    }()
    
    private(set) lazy var textField: CustomTextField = {
        return CustomTextField()
    }()
    
    private(set) lazy var errorLabel: CustomLabel = {
        let label = CustomLabel(style: .error)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Convenience Initializers
    convenience init(title: String, placeholder: String, isSecure: Bool = false) {
        self.init(frame: .zero)
        titleLabel.text = title
        textField.placeholder = placeholder
        
        if isSecure {
            textField.setupSecureTextEntry(isSecure: true, toggleButton: true)
        }
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(errorLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIConstants.Metrics.smallSpacing)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIConstants.Metrics.textFieldHeight)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(UIConstants.Metrics.microSpacing)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    func setupIcon(image: UIImage?, position: CustomTextField.IconPosition = .left) {
        textField.setupIcon(image: image, position: position)
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
    
    func setText(_ text: String?) {
        textField.text = text
    }
    
    func clearText() {
        textField.text = nil
    }
    
    func setError(_ error: String?) {
        if let error = error, !error.isEmpty {
            errorLabel.text = error
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func setAutocapitalizationType(_ type: UITextAutocapitalizationType) {
        textField.autocapitalizationType = type
    }
    
    func setAutocorrectionType(_ type: UITextAutocorrectionType) {
        textField.autocorrectionType = type
    }
} 
