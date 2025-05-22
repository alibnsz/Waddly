//
//  CustomSegmentedControl.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit
import SnapKit

class CustomSegmentedControl: UIView {
    
    // MARK: - Properties
    var selectedIndex: Int = 0 {
        didSet {
            updateSelectedState()
        }
    }
    
    var onValueChanged: ((Int) -> Void)?
    
    private var segments: [UIButton] = []
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    convenience init(items: [String]) {
        self.init(frame: .zero)
        setupSegments(items: items)
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .clear
        layer.cornerRadius = UIConstants.Metrics.cornerRadius
        layer.borderWidth = UIConstants.Metrics.borderWidth
        layer.borderColor = UIColor.appBorder.cgColor
        clipsToBounds = true
    }
    
    private func setupSegments(items: [String]) {
        // Remove any existing segments
        for segment in segments {
            segment.removeFromSuperview()
        }
        segments.removeAll()
        
        // Create new segments
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(item, for: .normal)
            button.titleLabel?.font = UIConstants.Fonts.smallFont
            button.tag = index
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            
            addSubview(button)
            segments.append(button)
        }
        
        // Arrange segments horizontally
        let segmentWidth = 1.0 / CGFloat(segments.count)
        
        for (index, segment) in segments.enumerated() {
            segment.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(segmentWidth)
                
                if index == 0 {
                    make.leading.equalToSuperview()
                } else {
                    make.leading.equalTo(segments[index - 1].snp.trailing)
                }
            }
        }
        
        // Set initial selected state
        updateSelectedState()
    }
    
    private func updateSelectedState() {
        for (index, segment) in segments.enumerated() {
            if index == selectedIndex {
                segment.backgroundColor = .appPrimary
                segment.setTitleColor(.appSecondary, for: .normal)
            } else {
                segment.backgroundColor = .clear
                segment.setTitleColor(.appPrimary, for: .normal)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func segmentTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        onValueChanged?(selectedIndex)
    }
    
    // MARK: - Public Methods
    func setSelectedIndex(_ index: Int) {
        guard index >= 0 && index < segments.count else { return }
        selectedIndex = index
    }
} 