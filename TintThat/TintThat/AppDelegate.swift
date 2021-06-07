//
//  AppDelegate.swift
//  TintThat
//
//  Created by Sebastian Cruz on 04/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Set default style for UITabBar
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .secondaryLight
        UITabBar.appearance().tintColor = .primaryDark
        UITabBar.appearance().unselectedItemTintColor = .secondaryDark
        
        // Set default style for UINavigationBar
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = .secondaryLight
        UINavigationBar.appearance().tintColor = .secondaryDark
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

