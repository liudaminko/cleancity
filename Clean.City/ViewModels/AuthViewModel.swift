//
//  AuthViewModel.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    func signInWithGoogle() async {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("❌ clientID is missing")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = await windowScene.windows.first?.rootViewController else {
            print("❌ No rootViewController")
            return
        }

        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

            guard let idToken = result.user.idToken?.tokenString else {
                print("❌ Не вдалося отримати ID Token")
                return
            }
            let accessToken = result.user.accessToken.tokenString


            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: accessToken
            )

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("❌ Firebase login error: \(error.localizedDescription)")
                } else {
                    print("✅ Firebase login success")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                }
            }

        } catch {
            print("❌ Google Sign-In error:", error.localizedDescription)
        }
    }


    
    func signInWithEmail(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign in failed:", error.localizedDescription)
                completion(false)
            } else {
                print("Signed in as:", result?.user.email ?? "no email")
                completion(true)
            }
        }
    }
}

