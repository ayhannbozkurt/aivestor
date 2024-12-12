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
struct AiVestorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var signInVM = SignInViewModel()

    var body: some Scene {
        WindowGroup {
            if let _ = signInVM.user {
                ContentView()
                    .environmentObject(signInVM)
            } else {
                SignInView(signInVM: signInVM)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        return true
    }
}



//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//}
