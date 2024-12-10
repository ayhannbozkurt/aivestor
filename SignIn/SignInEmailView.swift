//
//  SignInEmailView.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import SwiftUI

struct SignInEmailView: View {
    @ObservedObject var viewModel: SignInEmailViewModel
    @ObservedObject var signInVM: SignInViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showSignUpView: Bool = false
    @State private var showForgotPasswordView: Bool = false
    @State private var forgotPasswordEmail: String = ""
    @Binding var isUserLoggedIn: Bool
    @State private var showHelpView: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    // Başlık
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    // Logo
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 40)
                    
                    // Giriş formu
                    VStack(spacing: 16) {
                        TextField("Enter your email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                        
                        SecureField("Enter your password", text: $viewModel.password)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    if viewModel.isSignInProgress {
                        ProgressView()
                            .padding()
                    }
                    
                    // Devam butonu
                    Button(action: {
                        Task {
                            do {
                                let appUser = try await viewModel.signInWithEmail()
                                viewModel.appUser = appUser
                                isUserLoggedIn = true
                                alertTitle = "Success"
                                alertMessage = "Sign-in successful!"
                                showAlert = true
                            } catch {
                                alertTitle = "Error"
                                alertMessage = "Invalid login credentials"
                                showAlert = true
                            }
                        }
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .disabled(!viewModel.isFormValid)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(alertTitle),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}
