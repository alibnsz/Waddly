//
//  AuthRepository.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthRepository: AuthRepositoryProtocol {
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private let usersCollection = "users"
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let user = authResult?.user {
                self.getUserData(for: user.uid) { result in
                    switch result {
                    case .success(let userData):
                        // Token oluştur veya FirebaseAuth'tan al
                        user.getIDToken { token, error in
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                            
                            let authResponse = AuthResponse(
                                user: userData,
                                token: token ?? "",
                                refreshToken: user.refreshToken
                            )
                            completion(.success(authResponse))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı bilgileri alınamadı"])))
            }
        }
    }
    
    // MARK: - Register
    func register(firstName: String, lastName: String, email: String, password: String, role: Int, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let user = authResult?.user {
                // Kullanıcı bilgilerini güncelle
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = "\(firstName) \(lastName)"
                
                // Role bilgisini belirle
                let userRole = role == 0 ? UserRole.parent : UserRole.teacher
                
                changeRequest.commitChanges { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    // Firestore'a kaydet
                    let userData: [String: Any] = [
                        "id": user.uid,
                        "email": email,
                        "display_name": "\(firstName) \(lastName)",
                        "profile_image_url": "",
                        "first_name": firstName,
                        "last_name": lastName,
                        "role": userRole.rawValue,
                        "created_at": FieldValue.serverTimestamp()
                    ]
                    
                    self.db.collection(self.usersCollection).document(user.uid).setData(userData) { error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        
                        // Token oluştur
                        user.getIDToken { token, error in
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                            
                            let userModel = User(
                                id: user.uid,
                                email: email,
                                displayName: "\(firstName) \(lastName)",
                                profileImageURL: nil,
                                role: userRole
                            )
                            
                            let authResponse = AuthResponse(
                                user: userModel,
                                token: token ?? "",
                                refreshToken: user.refreshToken
                            )
                            completion(.success(authResponse))
                        }
                    }
                }
            } else {
                completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oluşturulamadı"])))
            }
        }
    }
    
    // MARK: - Social Login
    func loginWithApple(token: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: token, rawNonce: "")
        signInWithCredential(credential, completion: completion)
    }
    
    func loginWithGoogle(token: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let credential = GoogleAuthProvider.credential(withIDToken: token, accessToken: "")
        signInWithCredential(credential, completion: completion)
    }
    
    // MARK: - Logout
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    // MARK: - Current User
    func getCurrentUser() -> User? {
        guard let firebaseUser = auth.currentUser else { return nil }
        
        return User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName,
            profileImageURL: firebaseUser.photoURL?.absoluteString,
            role: nil
        )
    }
    
    // MARK: - Reset Password
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // MARK: - Helper Methods
    private func signInWithCredential(_ credential: AuthCredential, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        auth.signIn(with: credential) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let user = authResult?.user {
                self.getUserData(for: user.uid) { result in
                    switch result {
                    case .success(let userData):
                        // Token oluştur
                        user.getIDToken { token, error in
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                            
                            let authResponse = AuthResponse(
                                user: userData,
                                token: token ?? "",
                                refreshToken: user.refreshToken
                            )
                            completion(.success(authResponse))
                        }
                    case .failure:
                        // Firestore'da kullanıcı bulunamadığında kayıt işlemi yap
                        let userData: [String: Any] = [
                            "id": user.uid,
                            "email": user.email ?? "",
                            "display_name": user.displayName ?? "",
                            "profile_image_url": user.photoURL?.absoluteString ?? "",
                            "role": UserRole.parent.rawValue,
                            "created_at": FieldValue.serverTimestamp()
                        ]
                        
                        self.db.collection(self.usersCollection).document(user.uid).setData(userData) { error in
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                            
                            // Token oluştur
                            user.getIDToken { token, error in
                                if let error = error {
                                    completion(.failure(error))
                                    return
                                }
                                
                                let userModel = User(
                                    id: user.uid,
                                    email: user.email ?? "",
                                    displayName: user.displayName,
                                    profileImageURL: user.photoURL?.absoluteString,
                                    role: .parent
                                )
                                
                                let authResponse = AuthResponse(
                                    user: userModel,
                                    token: token ?? "",
                                    refreshToken: user.refreshToken
                                )
                                completion(.success(authResponse))
                            }
                        }
                    }
                }
            } else {
                completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı bilgileri alınamadı"])))
            }
        }
    }
    
    private func getUserData(for userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        db.collection(usersCollection).document(userId).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = snapshot?.data(),
               let id = data["id"] as? String,
               let email = data["email"] as? String {
                let displayName = data["display_name"] as? String
                let profileImageURL = data["profile_image_url"] as? String
                
                // Rol bilgisini al
                var role: UserRole? = nil
                if let roleString = data["role"] as? String,
                   let userRole = UserRole(rawValue: roleString) {
                    role = userRole
                }
                
                let user = User(
                    id: id,
                    email: email,
                    displayName: displayName,
                    profileImageURL: profileImageURL,
                    role: role
                )
                completion(.success(user))
            } else if let firebaseUser = self.auth.currentUser {
                // Firestore'da veri yoksa Firebase Auth'tan al
                let user = User(
                    id: firebaseUser.uid,
                    email: firebaseUser.email ?? "",
                    displayName: firebaseUser.displayName,
                    profileImageURL: firebaseUser.photoURL?.absoluteString,
                    role: nil
                )
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı verileri bulunamadı"])))
            }
        }
    }
} 