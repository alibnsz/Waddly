//
//  StringPaths.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import Foundation

// String yollarını enum içinde namespace olarak düzenleyerek erişimi kolaylaştıran yapı
struct StringPaths {
    
    // Login modülü için string yolları
    enum Login {
        enum View {
            static let email = "login.email"
            static let password = "login.password"
            static let forgotPassword = "login.forgotPassword"
            static let login = "login.loginButton"
            static let or = "login.or"
            static let continueWithApple = "login.continueWithApple"
            static let continueWithGoogle = "login.continueWithGoogle"
            static let noAccount = "login.noAccount"
            static let signUp = "login.signUp"
            static let emailPlaceholder = "login.emailPlaceholder"
            static let passwordPlaceholder = "login.passwordPlaceholder"
        }
        
        enum Error {
            static let emailEmpty = "login.error.emailEmpty"
            static let emailInvalid = "login.error.emailInvalid"
            static let passwordEmpty = "login.error.passwordEmpty"
            static let passwordTooShort = "login.error.passwordTooShort"
        }
        
        enum Alert {
            static let error = "login.alert.error"
            static let success = "login.alert.success"
            static let ok = "login.alert.ok"
            static let welcome = "login.alert.welcome"
        }
    }
    
    // Register modülü için string yolları
    enum Register {
        enum View {
            static let firstName = "register.firstName"
            static let lastName = "register.lastName"
            static let email = "register.email"
            static let phoneNumber = "register.phoneNumber"
            static let password = "register.password"
            static let confirmPassword = "register.confirmPassword"
            static let roleParent = "register.roleParent"
            static let roleTeacher = "register.roleTeacher"
            static let termsCheckbox = "register.termsCheckbox"
            static let privacyCheckbox = "register.privacyCheckbox"
            static let register = "register.registerButton"
            static let backButton = "register.backButton"
            static let title = "register.title"
            
            // Placeholders
            static let firstNamePlaceholder = "register.firstNamePlaceholder"
            static let lastNamePlaceholder = "register.lastNamePlaceholder"
            static let emailPlaceholder = "register.emailPlaceholder"
            static let phoneNumberPlaceholder = "register.phoneNumberPlaceholder"
            static let passwordPlaceholder = "register.passwordPlaceholder"
            static let confirmPasswordPlaceholder = "register.confirmPasswordPlaceholder"
        }
        
        enum Error {
            static let firstNameEmpty = "register.error.firstNameEmpty"
            static let lastNameEmpty = "register.error.lastNameEmpty"
            static let emailEmpty = "register.error.emailEmpty"
            static let emailInvalid = "register.error.emailInvalid"
            static let phoneNumberEmpty = "register.error.phoneNumberEmpty"
            static let phoneNumberInvalid = "register.error.phoneNumberInvalid"
            static let passwordEmpty = "register.error.passwordEmpty"
            static let passwordTooShort = "register.error.passwordTooShort"
            static let passwordsDoNotMatch = "register.error.passwordsDoNotMatch"
            static let termsNotAccepted = "register.error.termsNotAccepted"
            static let privacyNotAccepted = "register.error.privacyNotAccepted"
            static let roleNotSelected = "register.error.roleNotSelected"
        }
        
        enum Alert {
            static let error = "register.alert.error"
            static let success = "register.alert.success"
            static let ok = "register.alert.ok"
            static let registerSuccess = "register.alert.registerSuccess"
        }
    }
}

// String değerlerini localizable dosyasından almak için extension
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
} 