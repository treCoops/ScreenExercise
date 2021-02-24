//
//  AppDelegate.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-11.
//

import UIKit
import Firebase
import GoogleSignIn
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, UIWindowSceneDelegate {
    
    let appRefresher = AppRefreshOperation()
    
    var backgroundTaskId: UIBackgroundTaskIdentifier = .invalid
    
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
        
        
        self.executeAfterDelay(delay: 0.1, completion: {
            print("asd")
        })
        
    
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
    
    func executeAfterDelay(delay: TimeInterval, completion: @escaping(()->Void)){
//        backgroundTaskId = UIApplication.shared.beginBackgroundTask(
//            withName: "BackgroundSound",
//            expirationHandler: {[weak self] in
//                if let taskId = self?.backgroundTaskId{
//                    UIApplication.shared.endBackgroundTask(taskId)
//                }
//            })
//
//        let startTime = Date()
//        DispatchQueue.global(qos: .background).async {
//            while Date().timeIntervalSince(startTime) < delay{
//                Thread.sleep(forTimeInterval: 0.01)
//            }
//            DispatchQueue.main.async {[weak self] in
//                completion()
//                if let taskId = self?.backgroundTaskId{
//                    UIApplication.shared.endBackgroundTask(taskId)
//                }
//            }
//        }
        
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
//
//           print("time")
//        }
    }


}

