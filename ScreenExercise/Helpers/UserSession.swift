//
//  UserSession.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-03.
//

import Foundation

class UserSession {
    
    static func setAuthVerificationID(data: String, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func getUserDefault(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func set(data: Bool, key: String){
        UserDefaults.standard.set(data, forKey: key)
    }
}
