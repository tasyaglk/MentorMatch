//
//  MentorMatchApp.swift
//  MentorMatch
//
//  Created by Тася Галкина on 07.03.2024.
//

//import SwiftUI
//import Firebase
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        print("ok")
//        return true
//    }
//}
//
//@main
//struct YourApp: App {
//    // register app delegate for Firebase setup
//    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
//    var viewModel =  AuthFirebase()
//
//    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                WelcomeView()
//                    .environmentObject(viewModel)
//            }
//        }
//    }
//}

import SwiftUI
import Firebase


@main
struct MentorMatchApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                let viewModel =  AuthFirebase()
                WelcomeView()
                    .environmentObject(viewModel)
            }
        }
    }
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            print("ok")
            return true
        }
    }
}


//WindowGroup {
//    let viewModel = AppViewModel()
//    WelcomeView().environmentObject(viewModel)
//}
