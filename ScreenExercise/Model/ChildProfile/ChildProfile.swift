//
//  ChildProfile.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-11.
//
import Foundation
import RealmSwift

class ChildProfile: Object{
    @objc dynamic var childID = UUID().uuidString
    @objc dynamic var childName : String = ""
    @objc dynamic var childNickName : String = ""
    @objc dynamic var childAge : Int = 0
    @objc dynamic var childGender : String = ""
    @objc dynamic var taskPending : Int = 0
    @objc dynamic var taskCompleted : Int = 0
    @objc dynamic var taskIncompleted : Int = 0
    @objc dynamic var isActive : Bool = false
    @objc dynamic var totalActivityCompleted : Int = 10
//    @objc dynamic var profileImage: NSData = NSData()
    @objc dynamic var created : NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "childID"
    }
}


