//
//  BetaReadingApp.swift
//  BetaReading
//
//  Created by Julia Gościniak on 02/04/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct BetaReadingApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    var body: some Scene {
        WindowGroup {
            let authViewModel = AuthenticationViewModel()
            ContentView()
                .environmentObject(authViewModel)
            //HomeView()
            //AddText()
            //LoginView()
            //ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Finished launching!")
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        return true
    }
}
