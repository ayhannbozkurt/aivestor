//
//  SignInView.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import SwiftUI
//import GoogleSignIn

struct SignInView: View {
    @ObservedObject var signInVM: SignInViewModel // ViewModel bağlantısı
    @State private var showEmailSignInView: Bool = false
    @State private var errorMessage: String? = nil
    @State private var showErrorAlert: Bool = false
    @State private var isUserLoggedIn: Bool = false


    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 20)

                // Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 10)

                // E-posta ile giriş butonu
                CustomButton(
                    title: NSLocalizedString("Sign in with email", comment: ""),
                    action: {
                        showEmailSignInView = true
                    },
                    backgroundColor: .white,
                    font: .headline,
                    foregroundColor: .black,
                    cornerRadius: 10,
                    padding: 12,
                    imageName: "mailIcon",
                    imageFrame: CGSize(width: 24, height: 24)
                )
                .padding(.horizontal)
                .background(
                    NavigationLink(
                        destination: {
                            SignInEmailView(
                                viewModel: SignInEmailViewModel(),
                                signInVM: signInVM,
                                isUserLoggedIn: $isUserLoggedIn
                            )
                        },
                        label: {
                            EmptyView()
                        }
                    )
                    .hidden()
                )

                // Google ile giriş butonu
//                CustomButton(
//                    title: NSLocalizedString("Continue with Google", comment: ""),
//                    action: {
//                        Task {
//                            do {
//                                try await signInVM.signInWithGoogle()
//                            } catch {
//                                self.errorMessage = NSLocalizedString("Google Sign-In failed", comment: "")
//                                self.showErrorAlert = true
//                            }
//                        }
//                    },
//                    backgroundColor: .white,
//                    font: .headline,
//                    foregroundColor: .black,
//                    cornerRadius: 10,
//                    padding: 12,
//                    imageName: "googleIcon",
//                    imageFrame: CGSize(width: 24, height: 24)
//                )
//                .alert(isPresented: $showErrorAlert) {
//                    Alert(
//                        title: Text("Error"),
//                        message: Text(errorMessage ?? "An unknown error occurred."),
//                        dismissButton: .default(Text("OK"))
//                    )
//                }
//                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}

