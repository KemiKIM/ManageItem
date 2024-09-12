//
//  AppDelegate.swift
//  ManageItem
//
//  Created by 김성호 on 9/2/24.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      
        // init Setting UserDefault 'auth'
        if UserDefaults.standard.string(forKey: "auth") == nil {
            UserDefaults.standard.setValue("on", forKey: "auth")
        }
        
        FirebaseApp.configure()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .landscape
        } else {
            // Default는 세로
            return .portrait
        }
    }
    
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}

