//
//  AuthRepositoryProtocol.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void)
    func register(firstName: String, lastName: String, email: String, password: String, role: Int, completion: @escaping (Result<AuthResponse, Error>) -> Void)
    func loginWithApple(token: String, completion: @escaping (Result<AuthResponse, Error>) -> Void)
    func loginWithGoogle(token: String, completion: @escaping (Result<AuthResponse, Error>) -> Void)
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
    func getCurrentUser() -> User?
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void)
} 