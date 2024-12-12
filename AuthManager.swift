//
//  AuthManager.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()

    private init() {}

    func signInWithEmail(email: String, password: String) async throws -> User {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            return authResult.user
        } catch let authError as NSError {
            print("AuthManager Hata Kodu: \(authError.code), Açıklama: \(authError.localizedDescription)")
            throw authError
        }
    }

    // Google ile giriş
    //    func signInWithGoogle(idToken: String, accessToken: String) async throws -> User {
    //        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
    //        let authResult = try await Auth.auth().signIn(with: credential)
    //        return authResult.user
    //    }
}

