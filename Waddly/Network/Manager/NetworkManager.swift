//
//  NetworkManager.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Login Methods
    func login(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        // Gerçek uygulamada API çağrısı yapılır
        // Simüle edilmiş başarılı yanıt
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if email == "test@example.com" && password == "password" {
                completion(.success(()))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    func loginWithApple(token: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        // Apple ile giriş API çağrısı
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion(.success(()))
        }
    }
    
    func loginWithGoogle(token: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        // Google ile giriş API çağrısı
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion(.success(()))
        }
    }
}
