//
//  CustomActivity.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-13.
//

import Foundation
import RealmSwift

class CustomActivity : Object {
    @objc dynamic var activityID = UUID().uuidString
    @objc dynamic var activityName : String = ""
    @objc dynamic var activityDescription : String = ""
    @objc dynamic var timeSlotId : String = ""
    @objc dynamic var childId : String = ""
    @objc dynamic var created : NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "activityID"
    }

}

