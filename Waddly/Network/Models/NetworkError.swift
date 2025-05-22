//
//  NetworkError.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case invalidCredentials
    case serverError(String)
    case parsingError
    case networkNotAvailable
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Geçersiz URL."
        case .noData:
            return "Veri bulunamadı."
        case .invalidResponse:
            return "Geçersiz sunucu yanıtı."
        case .invalidCredentials:
            return "Geçersiz kullanıcı adı veya şifre."
        case .serverError(let message):
            return "Sunucu hatası: \(message)"
        case .parsingError:
            return "Veri işleme hatası."
        case .networkNotAvailable:
            return "İnternet bağlantısı bulunamadı."
        }
    }
}
