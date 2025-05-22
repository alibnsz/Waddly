//
//  AppColors.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit

struct AppColors {
    static let primaryColor = UIColor.black
    static let secondaryColor = UIColor.white
    static let accentColor = UIColor(red: 255/255, green: 111/255, blue: 60/255, alpha: 1.0) // Turuncu
    static let textPrimaryColor = UIColor.black
    static let textSecondaryColor = UIColor.darkGray
    static let borderColor = UIColor.lightGray.withAlphaComponent(0.5)
    static let backgroundColor = UIColor.white
    static let errorColor = UIColor.red
    static let successColor = UIColor.systemGreen
}

// Renklere kolay erişim için extension
extension UIColor {
    static var appPrimary: UIColor { return AppColors.primaryColor }
    static var appSecondary: UIColor { return AppColors.secondaryColor }
    static var appAccent: UIColor { return AppColors.accentColor }
    static var appTextPrimary: UIColor { return AppColors.textPrimaryColor }
    static var appTextSecondary: UIColor { return AppColors.textSecondaryColor }
    static var appBorder: UIColor { return AppColors.borderColor }
    static var appBackground: UIColor { return AppColors.backgroundColor }
    static var appError: UIColor { return AppColors.errorColor }
    static var appSuccess: UIColor { return AppColors.successColor }
} 