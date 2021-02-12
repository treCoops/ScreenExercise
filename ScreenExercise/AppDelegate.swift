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
        
        
        let childProfile = ChildProfile()
        childProfile.childName = "Trevo"
        childProfile.childNickName = "treCoops"
        childProfile.childAge = 12
        childProfile.childGender = "Male"
        
//        let data = NSData(data: UIImage(named: ""))
//
//        let data = NSData(data: self.imgChildProfilePicture.image!.jpegData(compressionQuality: 0.5)!)
//        let imgPNG = UIImage(data: data as Data)!
//
//        let dataPNGImg = NSData(data: imgPNG.pngData()!)

//        childProfile.profileImage = dataPNGImg
        
//        do {
//            let realm = try! Realm()
//            
//            try! realm.write{
//                realm.add(childProfile)
//            }
//        
//        } catch {
//            print("Realm Error : \(error)");
//        }
//        
//        var childers : Results<ChildProfile>!
//        
//        let realm = try! Realm()
//        childers = realm.objects(ChildProfile.self)
//        print(childers.count)
//        
//        for childaaers in childers {
//         
//            print("Model Course = \(childaaers.childAge)")
//
//        }
        
    
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

