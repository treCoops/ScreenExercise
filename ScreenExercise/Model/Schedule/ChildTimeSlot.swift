//
//  ChildTimeSlot.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-17.
//

import Foundation

import RealmSwift

class ChildTimeSlot : Object {

    @objc dynamic var timeID = UUID().uuidString
    @objc dynamic var childID : String = ""
    @objc dynamic var activityID : String = ""
    @objc dynamic var completeStatus : String = ""
    @objc dynamic var time : String = ""
    @objc dynamic var isAssigned : Bool = false
    @objc dynamic var task : String = ""
    @objc dynamic var imgRef : String = ""
    @objc dynamic var created : NSDate = NSDate()

    override static func primaryKey() -> String? {
        return "timeID"
    }
}
