//
//  VakifBankApp.swift
//  VakifBank
//
//  Created by Emine CETINKAYA on 9.12.2024.
//

import SwiftUI
import Firebase
//import GoogleSignIn

@main
struct VakifBankApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SignInEmailView(
                         viewModel: SignInEmailViewModel(),
                         signInVM: SignInViewModel(),
                         isUserLoggedIn: .constant(false)
                     )
                   }
               }
        }

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//}
