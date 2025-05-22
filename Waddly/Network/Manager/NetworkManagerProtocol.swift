//
//  NetworkManagerProtocol.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func loginWithApple(token: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    func loginWithGoogle(token: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
}
