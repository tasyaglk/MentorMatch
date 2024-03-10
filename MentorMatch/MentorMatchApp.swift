//
//  MentorMatchApp.swift
//  MentorMatch
//
//  Created by Тася Галкина on 07.03.2024.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeView()
                    .environmentObject(viewModel)
            }
        }
    }
}


