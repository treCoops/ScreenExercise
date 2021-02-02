//
//  AppRefreshOperation.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-20.
//

import Foundation
import BackgroundTasks

class AppRefreshOperation {
    
    func registerBackgroundTasks() {
        if #available(iOS 13, *) {
            BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.se.appRefresh", using: nil) { task in
                print("[BGTASK] Perform bg fetch com.se.appRefresh")
                task.setTaskCompleted(success: true)
                self.scheduleAppRefresh()
            }

            BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.se.appProcess", using: nil) { task in
                print("[BGTASK] Perform bg processing com.se.appProcess")
                task.setTaskCompleted(success: true)
                self.scheduleBackgroundProcessing()
            }
        }
    }
    
    @available(iOS 13.0, *)
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.se.appRefresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 10)
       
        do {
            try BGTaskScheduler.shared.submit(request)
            print("App Refresh")
        } catch {
            print("Could not schedule app refresh: \(error.localizedDescription)")
        }
    }
    
    @available(iOS 13.0, *)
    func scheduleBackgroundProcessing() {
        let request = BGProcessingTaskRequest(identifier: "com.se.appProcess")
        request.requiresNetworkConnectivity = true // Need to true if your task need to network process. Defaults to false.
        request.requiresExternalPower = true // Need to true if your task requires a device connected to power source. Defaults to false.

        request.earliestBeginDate = Date(timeIntervalSinceNow: 10)
       
        do {
            try BGTaskScheduler.shared.submit(request)
            print("App Process")
        } catch {
            print("Could not schedule image fetch: (error)")
        }
    }
    
}
