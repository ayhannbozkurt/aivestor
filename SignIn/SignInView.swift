//
//  SignInView.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var signInVM: SignInViewModel
    @State private var showErrorAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 20)

                TextField("Enter your email", text: $signInVM.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                SecureField("Enter your password", text: $signInVM.password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                Button(action: {
                    Task {
                        await signInVM.signInWithEmail()
                        if signInVM.errorMessage != nil {
                            showErrorAlert = true
                        }
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(signInVM.errorMessage ?? "An unknown error occurred."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

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

    
