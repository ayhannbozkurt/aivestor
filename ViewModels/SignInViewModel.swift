//
//  SignInViewModel.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 8.12.2024.
//

import FirebaseAuth
//import GoogleSignIn
import SwiftUI

@MainActor
class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var user: User? = nil

    func signInWithEmail() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let user = try await AuthManager.shared.signInWithEmail(email: email, password: password)
            self.user = user
            self.errorMessage = nil // Hata olmadığını belirtmek için sıfırla
        } catch let authError as NSError {
            print("Firebase Hata Kodu: \(authError.code), Açıklama: \(authError.localizedDescription)")

            // Firebase hata kodlarını kontrol edin ve doğru mesajı ayarlayın
            switch authError.code {
            case AuthErrorCode.wrongPassword.rawValue:
                self.errorMessage = "The password you entered is incorrect. Please try again."
            case AuthErrorCode.invalidEmail.rawValue:
                self.errorMessage = "The email address you entered is invalid."
            case AuthErrorCode.userNotFound.rawValue:
                self.errorMessage = "No account found with this email address."
            default:
                self.errorMessage = "An unknown error occurred: \(authError.localizedDescription)"
            }
        }
    }
    
    // Google ile giriş
    //    func signInWithGoogle() async {
    //        isLoading = true
    //        defer { isLoading = false }
    //
    //        do {
    //            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
    //                  let rootViewController = windowScene.windows.first?.rootViewController else {
    //                throw NSError(domain: "Google Sign-In", code: -2, userInfo: [NSLocalizedDescriptionKey: "RootViewController bulunamadı"])
    //            }
    //
    //            let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
    //            guard let idToken = signInResult.user.idToken?.tokenString else {
    //                throw NSError(domain: "Google Sign-In", code: -3, userInfo: [NSLocalizedDescriptionKey: "ID Token alınamadı"])
    //            }
    //            let accessToken = signInResult.user.accessToken.tokenString
    //
    //
    //            let user = try await AuthManager.shared.signInWithGoogle(idToken: idToken, accessToken: signInResult.user.accessToken.tokenString)
    //            self.user = user
    //        } catch {
    //            self.errorMessage = "Google oturum açma işlemi başarısız oldu. Lütfen tekrar deneyin."
    //        }
    //    }
}
