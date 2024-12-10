//
//  AuthError.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import Foundation

struct AuthError: Error {
    enum ErrorType {
        case invalidCredentials
        case userNotFound
        case signInFailed
        case noCurrentUser
        case invalidForm
        case networkError(description: String)
        case customError(description: String)
    }

    let type: ErrorType
    let description: String?

    // Eklenen init fonksiyonu ile description varsayılan olarak nil yapılabilir.
    init(type: ErrorType, description: String? = nil) {
        self.type = type
        self.description = description
    }

    var localizedDescription: String {
        switch type {
        case .invalidCredentials:
            return NSLocalizedString("Invalid credentials. Please check your email and password.", comment: "")
        case .userNotFound:
            return NSLocalizedString("No user found with this email.", comment: "")
        case .signInFailed:
            return NSLocalizedString("Failed to sign in user.", comment: "")
        case .noCurrentUser:
            return NSLocalizedString("No current user logged in.", comment: "")
        case .invalidForm:
            return NSLocalizedString("Invalid email or password format.", comment: "")
        case let .networkError(description):
            return NSLocalizedString("Network error: \(description)", comment: "")
        case let .customError(description):
            return NSLocalizedString(description, comment: "")
        }
    }
}
