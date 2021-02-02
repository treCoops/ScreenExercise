//
//  NotificationManager.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-20.
//

import UserNotifications

struct Notification {
    var id: String
    var title: String
}

class NotificationManager {       
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted == true && error == nil {
                    
                }
        }
    }
    
    func setNotification(title: String) -> Void {
        let content = UNMutableNotificationContent()
        content.title = title
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "1", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    guard error == nil else { return }
                    print("Scheduling notification with id: 1")
                }
    }
    
    func showNotification(title: String) -> Void {
          UNUserNotificationCenter.current().getNotificationSettings { settings in
              switch settings.authorizationStatus {
              case .notDetermined:
                  self.requestPermission()
              case .authorized, .provisional:
                  self.setNotification(title: title)
              default:
                  break
              }
          }
      }
}
