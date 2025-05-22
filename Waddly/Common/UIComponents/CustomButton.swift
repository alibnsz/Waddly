//
//  CustomButton.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit
import SnapKit

class CustomButton: UIButton {
    
    // MARK: - Enums
    enum ButtonStyle {
        case primary
        case secondary
        case social
    }
    
    // MARK: - Properties
    private var iconImageView: UIImageView?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Setup
    private func setupButton() {
        layer.cornerRadius = UIConstants.Metrics.cornerRadius
        titleLabel?.font = UIConstants.Fonts.buttonFont
    }
    
    // MARK: - Public Methods
    func configure(with style: ButtonStyle, title: String) {
        setTitle(title, for: .normal)
        
        switch style {
        case .primary:
            backgroundColor = .appPrimary
            setTitleColor(.appSecondary, for: .normal)
        case .secondary:
            backgroundColor = .appSecondary
            setTitleColor(.appPrimary, for: .normal)
            layer.borderWidth = UIConstants.Metrics.borderWidth
            layer.borderColor = UIColor.appBorder.cgColor
        case .social:
            backgroundColor = .appSecondary
            setTitleColor(.appPrimary, for: .normal)
            layer.borderWidth = UIConstants.Metrics.borderWidth
            layer.borderColor = UIColor.appBorder.cgColor
        }
    }
    
    func addIcon(image: UIImage?, tintColor: UIColor? = nil) {
        guard let image = image else { return }
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        if let tintColor = tintColor {
            imageView.tintColor = tintColor
        }
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(UIConstants.Metrics.iconLeftPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(UIConstants.Metrics.iconSize)
        }
        
        titleEdgeInsets = UIConstants.EdgeInsets.buttonTitleInsets
        
        self.iconImageView = imageView
    }
} 
