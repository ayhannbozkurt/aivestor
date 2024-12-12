//
//  SignInEmailViewModel.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import FirebaseAuth
import os
import SwiftUI

class SignInEmailViewModel: ObservableObject {
    @Published var email: String = "" {
        didSet { checkFormValidity() }
    }

    @Published var password: String = "" {
        didSet { checkFormValidity() }
    }

    @Published var isSignInProgress: Bool = false
    @Published var errorMessage: String?
    @Published var appUser: User?
    @Published var isFormValid: Bool = false

    init() {
        checkFormValidity()
    }

    private func checkFormValidity() {
        isFormValid = ValidationUtils.isValidEmail(email) && ValidationUtils.isValidPassword(password)
    }

    func signInWithEmail() async throws -> User {
        DispatchQueue.main.async {
            self.isSignInProgress = true
        }
        defer {
            DispatchQueue.main.async {
                self.isSignInProgress = false
            }
        }

        guard isFormValid else {
            throw AuthError(type: .invalidForm)
        }

        do {
            let appUser = try await AuthManager.shared.signInWithEmail(email: email, password: password)
            DispatchQueue.main.async {
                self.appUser = appUser
            }
            return appUser
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
            throw error
        }
    }
}

