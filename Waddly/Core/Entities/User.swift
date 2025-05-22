//
//  User.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import Foundation

// MARK: - UserRole Enum
enum UserRole: String, Codable {
    case parent = "parent"
    case teacher = "teacher"
    
    var displayName: String {
        switch self {
        case .parent: return "Veli"
        case .teacher: return "Öğretmen"
        }
    }
}

struct User: Codable {
    let id: String
    let email: String
    let displayName: String?
    let profileImageURL: String?
    let role: UserRole?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case displayName = "display_name"
        case profileImageURL = "profile_image_url"
        case role
    }
}

// Login Response için model
struct AuthResponse: Codable {
    let user: User
    let token: String
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case user
        case token
        case refreshToken = "refresh_token"
    }
} 