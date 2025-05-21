//
//  Clean_CityApp.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import FirebaseAuth
import UIKit

@main
struct Clean_CityApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var isLaunching = true
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some Scene {
        WindowGroup {
            if isLaunching {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLaunching = false
                        }
                    }
            } else {
                if isLoggedIn {
                    AppNavigationView()
                        .environmentObject(profileViewModel)
                        .onAppear {
                            Task {
                                if profileViewModel.profile == nil,
                                   let uid = Auth.auth().currentUser?.uid {
                                    await profileViewModel.fetchProfile(uid: uid)
                                }
                            }
                        }
                } else {
                    GreetView()
                }
            }
        }
    }
}

