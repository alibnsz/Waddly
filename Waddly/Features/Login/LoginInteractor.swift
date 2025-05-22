//
//  LoginInteractor.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation
import Security

// MARK: - Storage Keys
private enum StorageKeys {
    static let lastLoggedInEmail = "lastLoggedInEmail"
    static let authToken = "authToken"
    static let currentUser = "currentUser"
}

final class LoginInteractor: PresenterToInteractorLoginProtocol {
    
    // MARK: - Properties
    weak var presenter: InteractorToPresenterLoginProtocol?
    private let authRepository: AuthRepositoryProtocol
    private let userDefaults: UserDefaults
    private let keychainService: String
    
    // MARK: - Initialization
    init(
        authRepository: AuthRepositoryProtocol = AuthRepository(),
        userDefaults: UserDefaults = .standard,
        keychainService: String = "com.waddly.keychain"
    ) {
        self.authRepository = authRepository
        self.userDefaults = userDefaults
        self.keychainService = keychainService
    }
    
    // MARK: - Authentication Methods
    func loginUser(email: String, password: String) {
        authRepository.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // Kullanıcı rolünü debug için yazdır
                if let role = response.user.role {
                    print("Kullanıcı rolü: \(role.rawValue) - \(role.displayName)")
                } else {
                    print("Kullanıcının rolü bulunamadı")
                }
                
                self.saveUserSession(user: response.user, token: response.token)
                self.presenter?.loginSuccess(user: response.user)
            case .failure(let error):
                self.presenter?.loginFailure(error: error.localizedDescription)
            }
        }
    }
    
    func loginWithApple() {
        // In a real app, we would get a real token from Apple Sign In
        // For now, we're mocking this process
        let mockToken = "apple_mock_token"
        
        authRepository.loginWithApple(token: mockToken) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // Kullanıcı rolünü debug için yazdır
                if let role = response.user.role {
                    print("Apple login - Kullanıcı rolü: \(role.rawValue) - \(role.displayName)")
                } else {
                    print("Apple login - Kullanıcının rolü bulunamadı")
                }
                
                self.saveUserSession(user: response.user, token: response.token)
                self.presenter?.loginSuccess(user: response.user)
            case .failure(let error):
                self.presenter?.loginFailure(error: error.localizedDescription)
            }
        }
    }
    
    func loginWithGoogle() {
        // In a real app, we would get a real token from Google Sign In
        // For now, we're mocking this process
        let mockToken = "google_mock_token"
        
        authRepository.loginWithGoogle(token: mockToken) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // Kullanıcı rolünü debug için yazdır
                if let role = response.user.role {
                    print("Google login - Kullanıcı rolü: \(role.rawValue) - \(role.displayName)")
                } else {
                    print("Google login - Kullanıcının rolü bulunamadı")
                }
                
                self.saveUserSession(user: response.user, token: response.token)
                self.presenter?.loginSuccess(user: response.user)
            case .failure(let error):
                self.presenter?.loginFailure(error: error.localizedDescription)
            }
        }
    }
    
    // MARK: - User Session Management
    func saveUserSession(user: User, token: String) {
        // Son giriş yapılan e-posta adresini UserDefaults'a kaydet
        userDefaults.set(user.email, forKey: StorageKeys.lastLoggedInEmail)
        
        // Token'ı Keychain'e kaydet
        saveToKeychain(key: StorageKeys.authToken, data: token.data(using: .utf8)!)
        
        // Kullanıcı bilgilerini Keychain'e kaydet
        if let userData = try? JSONEncoder().encode(user) {
            saveToKeychain(key: StorageKeys.currentUser, data: userData)
        }
    }
    
    func getLastLoggedInEmail() -> String? {
        return userDefaults.string(forKey: StorageKeys.lastLoggedInEmail)
    }
    
    // MARK: - Keychain Helper Methods
    private func saveToKeychain(key: String, data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Önce mevcut anahtarı sil
        SecItemDelete(query as CFDictionary)
        
        // Yeni değeri ekle
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Error saving to Keychain: \(status)")
        }
    }
    
    private func loadFromKeychain(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            return result as? Data
        } else {
            return nil
        }
    }
}
