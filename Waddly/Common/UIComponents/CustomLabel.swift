//
//  CustomLabel.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit

class CustomLabel: UILabel {
    
    // MARK: - Enum
    enum LabelStyle {
        case title
        case header
        case bodyMedium
        case bodyLight
        case caption
        case error
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaults()
    }
    
    // MARK: - Convenience Initializers
    convenience init(style: LabelStyle, text: String? = nil) {
        self.init(frame: .zero)
        self.text = text
        applyStyle(style)
    }
    
    // MARK: - Private Methods
    private func setupDefaults() {
        // Varsayılan ayarlar
        textAlignment = .left
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    // MARK: - Public Methods
    func applyStyle(_ style: LabelStyle) {
        switch style {
        case .title:
            font = UIConstants.Fonts.titleFont
            textColor = .appTextPrimary
            
        case .header:
            font = UIConstants.Fonts.headerFont
            textColor = .appTextPrimary
            
        case .bodyMedium:
            font = UIConstants.Fonts.bodyMediumFont
            textColor = .appTextPrimary
            
        case .bodyLight:
            font = UIConstants.Fonts.bodyLightFont
            textColor = .appTextPrimary
            
        case .caption:
            font = UIConstants.Fonts.captionFont
            textColor = .appTextSecondary
            
        case .error:
            font = UIConstants.Fonts.captionFont
            textColor = .appError
        }
    }
} 