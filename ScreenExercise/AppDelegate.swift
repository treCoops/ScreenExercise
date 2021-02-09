//
//  AppDelegate.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit
import Firebase
import GoogleSignIn


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, UIWindowSceneDelegate {
    
    let appRefresher = AppRefreshOperation()
    
    func userNotificationCenter(
           _ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
           -> Void) {
        
        completionHandler([.banner, .badge, .sound])
       }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Background")
        appRefresher.scheduleAppRefresh()
        appRefresher.scheduleBackgroundProcessing()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        appRefresher.registerBackgroundTasks()
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
    }


}

