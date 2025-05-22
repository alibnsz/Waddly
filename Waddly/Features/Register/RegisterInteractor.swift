//
//  RegisterInteractor.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation
import Security

// MARK: - Storage Keys
private enum StorageKeys {
    static let authToken = "authToken"
    static let currentUser = "currentUser"
}

final class RegisterInteractor: PresenterToInteractorRegisterProtocol {

    // MARK: - Properties
    weak var presenter: InteractorToPresenterRegisterProtocol?
    private let authRepository: AuthRepositoryProtocol
    private let keychainService: String
    
    // MARK: - Initialization
    init(
        authRepository: AuthRepositoryProtocol = AuthRepository(),
        keychainService: String = "com.waddly.keychain"
    ) {
        self.authRepository = authRepository
        self.keychainService = keychainService
    }
    
    // MARK: - Methods
    func registerUser(
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        password: String,
        role: Int
    ) {
        // Firebase Auth ile kullanıcı kaydı - role parametresini de gönderiyoruz
        authRepository.register(firstName: firstName, lastName: lastName, email: email, password: password, role: role) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // Kullanıcı verisini ve token'ı güvenli bir şekilde sakla
                self.saveUserSession(user: response.user, token: response.token)
                self.presenter?.registerSuccess()
            case .failure(let error):
                self.presenter?.registerFailure(error: error)
            }
        }
    }
    
    // MARK: - Helper Methods
    private func saveUserSession(user: User, token: String) {
        // Token'ı Keychain'e kaydet
        saveToKeychain(key: StorageKeys.authToken, data: token.data(using: .utf8)!)
        
        // Kullanıcı bilgilerini Keychain'e kaydet
        if let userData = try? JSONEncoder().encode(user) {
            saveToKeychain(key: StorageKeys.currentUser, data: userData)
        }
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
