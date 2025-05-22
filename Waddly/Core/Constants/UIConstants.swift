//
//  UIConstants.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit

/// Uygulama genelinde kullanılan UI sabitleri
struct UIConstants {
    
    /// Genel Metrik Değerleri
    struct Metrics {
        // Boşluklar
        static let horizontalMargin: CGFloat = 24
        static let standardSpacing: CGFloat = 20
        static let halfSpacing: CGFloat = 10
        static let smallSpacing: CGFloat = 8
        static let microSpacing: CGFloat = 4
        
        // Yükseklikler
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
        static let dividerHeight: CGFloat = 20
        static let iconSize: CGFloat = 20
        static let standardWidth: CGFloat = UIScreen.main.bounds.width - (horizontalMargin * 2)
        
        // Köşe yuvarlaklıkları
        static let cornerRadius: CGFloat = 12
        static let borderWidth: CGFloat = 1
        
        // Dinamik Boşluklar
        static var topSpace: CGFloat {
            return min(UIScreen.main.bounds.height * 0.05, 30)
        }
        
        static var standardDynamicSpace: CGFloat {
            return min(UIScreen.main.bounds.height * 0.02, 20)
        }
        
        // İkon Pozisyonları
        static let iconLeftPadding: CGFloat = 20
        static let iconContainerWidth: CGFloat = 40
        static let textLeftPadding: CGFloat = 10
        static let textRightPadding: CGFloat = 10
    }
    
    /// Font Değerleri
    struct Fonts {
        // Metin fontları
        static let titleFont = UIFont.systemFont(ofSize: 32, weight: .light)
        static let headerFont = UIFont.systemFont(ofSize: 24, weight: .medium)
        static let bodyMediumFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let bodyLightFont = UIFont.systemFont(ofSize: 14, weight: .light)
        static let textFieldFont = UIFont.systemFont(ofSize: 12, weight: .light)
        static let smallFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let buttonFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let captionFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    /// Kenar Boşlukları
    struct EdgeInsets {
        static let buttonTitleInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        static let textFieldInsets = UIEdgeInsets(top: 0, left: Metrics.textLeftPadding, bottom: 0, right: Metrics.textRightPadding)
        static let iconTextFieldInsets = UIEdgeInsets(top: 0, left: Metrics.iconContainerWidth, bottom: 0, right: Metrics.textRightPadding)
    }
} 
