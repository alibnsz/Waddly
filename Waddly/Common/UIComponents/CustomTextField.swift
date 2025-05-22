//
//  CustomTextField.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit
import SnapKit

class CustomTextField: UITextField {
    
    // MARK: - Enums
    enum IconPosition {
        case left, right, both
    }
    
    // MARK: - Properties
    private var leftIconView: UIView?
    private var rightIconView: UIView?
    private var rightIconButton: UIButton?
    private var rightButtonContainerView: UIView?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // İkon view'ların içindeki ikonların yerini güncelleyelim
        if let leftIconContainer = leftIconView {
            for subview in leftIconContainer.subviews {
                if let imageView = subview as? UIImageView {
                    imageView.center = CGPoint(x: UIConstants.Metrics.iconLeftPadding, y: leftIconContainer.bounds.height / 2)
                }
            }
        }
        
        if let rightIconContainer = rightIconView {
            for subview in rightIconContainer.subviews {
                if let imageView = subview as? UIImageView {
                    imageView.center = CGPoint(x: UIConstants.Metrics.iconLeftPadding, y: rightIconContainer.bounds.height / 2)
                }
            }
        }
        
        // Sağ buton için de aynısını yapalım
        if let button = rightIconButton, let container = rightButtonContainerView {
            button.center = CGPoint(x: container.bounds.width / 2, y: container.bounds.height / 2)
        }
    }
    
    // MARK: - Setup
    private func setupTextField() {
        borderStyle = .roundedRect
        backgroundColor = .appBackground
        layer.borderWidth = UIConstants.Metrics.borderWidth
        layer.borderColor = UIColor.appBorder.cgColor
        layer.cornerRadius = UIConstants.Metrics.cornerRadius
        clipsToBounds = true
        font = UIConstants.Fonts.textFieldFont
        tintColor = .black // Cursor rengini siyah olarak ayarlıyorum
        
        // Placeholder'ı daha ince yapalım
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIConstants.Fonts.textFieldFont,
            .foregroundColor: UIColor.appTextSecondary
        ]
        
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: placeholderAttributes
            )
        }
    }
    
    // Custom textRect ve editingRect metodları ile hem edit modu hem de normal mod için padding ayarlıyorum
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // Eğer sol tarafta icon varsa daha fazla padding ekle
        let leftPadding: CGFloat = leftIconView != nil ? 
            UIConstants.Metrics.iconContainerWidth : UIConstants.Metrics.textLeftPadding
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: UIConstants.Metrics.textRightPadding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        // Eğer sol tarafta icon varsa daha fazla padding ekle
        let leftPadding: CGFloat = leftIconView != nil ? 
            UIConstants.Metrics.iconContainerWidth : UIConstants.Metrics.textLeftPadding
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: UIConstants.Metrics.textRightPadding))
    }
    
    // Placeholder özelliği değiştiğinde özel formatı korumak için
    override var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                let placeholderAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIConstants.Fonts.textFieldFont,
                    .foregroundColor: UIColor.appTextSecondary
                ]
                attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: placeholderAttributes
                )
            }
        }
    }
    
    // MARK: - Public Methods
    func setupIcon(image: UIImage?, position: IconPosition, tintColor: UIColor = .appTextSecondary) {
        switch position {
        case .left:
            setupLeftIcon(image: image, tintColor: tintColor)
        case .right:
            setupRightIcon(image: image, tintColor: tintColor)
        case .both:
            setupLeftIcon(image: image, tintColor: tintColor)
            setupRightIcon(image: image, tintColor: tintColor)
        }
    }
    
    func setupSecureTextEntry(isSecure: Bool = true, toggleButton: Bool = false) {
        isSecureTextEntry = isSecure
        
        if toggleButton {
            // Container view
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstants.Metrics.iconContainerWidth, height: UIConstants.Metrics.textFieldHeight))
            
            // Button
            let button = UIButton(type: .custom)
            let imageName = isSecure ? "eye.slash" : "eye"
            button.setImage(UIImage(systemName: imageName), for: .normal)
            button.tintColor = .appTextSecondary
            button.frame = CGRect(x: 0, y: 0, width: UIConstants.Metrics.iconSize + 4, height: UIConstants.Metrics.iconSize + 4)
            button.center = CGPoint(x: containerView.bounds.width / 2, y: containerView.bounds.height / 2)
            button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            
            containerView.addSubview(button)
            
            rightIconButton = button
            rightButtonContainerView = containerView
            rightView = containerView
            rightViewMode = .always
        }
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        
        // Butona basıldığında placeholder'daki metin seçiliyse, seçimi kaldıralım
        // ve cursor'u koruyalım
        let originalCursorPosition = selectedTextRange
        
        if let button = rightIconButton {
            let imageName = isSecureTextEntry ? "eye.slash" : "eye"
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        // Cursor pozisyonunu geri yükleyelim
        selectedTextRange = originalCursorPosition
    }
    
    // MARK: - Private Methods
    private func setupLeftIcon(image: UIImage?, tintColor: UIColor) {
        guard let image = image else { return }
        
        // Sabit boyutlu container view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstants.Metrics.iconContainerWidth, height: UIConstants.Metrics.textFieldHeight))
        
        let iconView = UIImageView(image: image)
        iconView.tintColor = tintColor
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: UIConstants.Metrics.iconSize, height: UIConstants.Metrics.iconSize)
        iconView.center = CGPoint(x: UIConstants.Metrics.iconLeftPadding, y: containerView.bounds.height / 2) // Dikey ortalama
        
        containerView.addSubview(iconView)
        
        leftView = containerView
        leftViewMode = .always
        leftIconView = containerView
    }
    
    private func setupRightIcon(image: UIImage?, tintColor: UIColor) {
        guard let image = image else { return }
        
        // Sabit boyutlu container view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstants.Metrics.iconContainerWidth, height: UIConstants.Metrics.textFieldHeight))
        
        let iconView = UIImageView(image: image)
        iconView.tintColor = tintColor
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: UIConstants.Metrics.iconSize, height: UIConstants.Metrics.iconSize)
        iconView.center = CGPoint(x: UIConstants.Metrics.iconLeftPadding, y: containerView.bounds.height / 2) // Dikey ortalama
        
        containerView.addSubview(iconView)
        
        rightView = containerView
        rightViewMode = .always
        rightIconView = containerView
    }
} 
