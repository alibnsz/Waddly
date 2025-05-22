//
//  CustomCheckbox.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit
import SnapKit

class CustomCheckbox: UIView {
    
    // MARK: - Properties
    private(set) var isChecked: Bool = false
    
    var onValueChanged: ((Bool) -> Void)?
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .appPrimary
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(style: .bodyLight)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        titleLabel.text = title
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(checkboxButton)
        addSubview(titleLabel)
        
        checkboxButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkboxButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(checkboxButton)
        }
        
        // Make the entire view tappable
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCheckbox))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    @objc private func toggleCheckbox() {
        isChecked.toggle()
        checkboxButton.isSelected = isChecked
        onValueChanged?(isChecked)
    }
    
    // MARK: - Public Methods
    func setChecked(_ checked: Bool) {
        isChecked = checked
        checkboxButton.isSelected = checked
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
} 