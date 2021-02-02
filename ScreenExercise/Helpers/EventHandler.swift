//
//  EventHandler.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-25.
//

import UIKit
import EventKit
import EventKitUI

class EventHandler {
    let store = EKEventStore()
    var granted: Bool = true
    
    func checkEventStoreAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        
        switch status {
            case .authorized:
                self.accessGrantedForReminders()
            case .notDetermined:
                self.requestAccess()
            case .denied, .restricted:
                self.accessDeniedForReminders()
            @unknown default:
                break
            }
    }
    
    func accessGrantedForReminders() {
        self.granted = true
    }
    
    func requestAccess() {
        store.requestAccess(to: .reminder) { granted, error in
            print("Requested permission granted!")
        }
    }
    
    func accessDeniedForReminders(){
        print("Remainder access are denied!")
    }
    
    func createRemainder(){
        
        if(granted){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: "2021/01/25 13:20")!
            
            let alarm = EKAlarm(absoluteDate: someDateTime)
            
            let reminder:EKReminder = EKReminder(eventStore: store)
            reminder.title = "Must do this!"
            reminder.priority = 1
            reminder.notes = "...this is a note"
            reminder.addAlarm(alarm)
            reminder.calendar = self.store.defaultCalendarForNewReminders()
            
            do {
                try self.store.save(reminder, commit: true)
            } catch {
                print("Cannot save")
                return
            }
            print("Reminder saved")
        }

    }
    
    

}

