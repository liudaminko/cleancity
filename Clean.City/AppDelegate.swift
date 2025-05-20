//
//  AppDelegate.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//\

import UIKit
import Foundation
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("✅ AppDelegate running")
        return true
    }
}
