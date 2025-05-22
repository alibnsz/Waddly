//
//  ImagePaths.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit

/// Uygulama genelinde kullanılan görsel kaynaklarını merkezi olarak yöneten yapı.
/// Böylece görsel adları değişse bile sadece burada güncelleme yapmak yeterli olacak.
struct ImagePaths {
    
    /// Asset katalogundaki görsel referanslarını döndürür
    static func image(named: String) -> UIImage? {
        return UIImage(named: named)
    }
    
    /// SF Symbols ikonlarını döndürür
    static func systemIcon(named: String) -> UIImage? {
        return UIImage(systemName: named)
    }
    
    /// Logo ve Marka Görselleri
    struct Logos {
        static let appLogo = "appLogo"
        static let appLogoSmall = "appLogoSmall"
        static let appLogoDark = "appLogoDark"
    }
    
    /// Onboarding Görselleri
    struct Onboarding {
        static let welcome = "onboarding_welcome"
        static let features = "onboarding_features"
        static let getStarted = "onboarding_getstarted"
    }
    
    /// Giriş ve Kullanıcı İşlemleri İkonları
    struct Auth {
        // System Icons (SF Symbols)
        static let email = "envelope"
        static let password = "lock"
        static let passwordVisible = "eye"
        static let passwordHidden = "eye.slash"
        static let appleLogo = "apple.logo"
        static let person = "person"
        static let phone = "phone"
        static let backArrow = "arrow.left"
        
        // Asset Icons
        static let googleIcon = "googleIcon"
        static let appleIcon = "appleIcon"
    }
    
    /// Ana Sayfa ve İçerik Görselleri
    struct Home {
        static let placeholder = "image_placeholder"
        static let defaultAvatar = "default_avatar"
    }
    
    /// Tab Bar İkonları
    struct TabBar {
        static let home = "house"
        static let search = "magnifyingglass"
        static let notifications = "bell"
        static let profile = "person"
    }
    
    /// Ortak Kullanılan İkonlar
    struct Common {
        static let back = "chevron.left"
        static let forward = "chevron.right"
        static let close = "xmark"
        static let add = "plus"
        static let settings = "gear"
        static let more = "ellipsis"
    }
} 