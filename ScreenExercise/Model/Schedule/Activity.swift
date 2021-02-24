//
//  Activity.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-24.
//

import Foundation
import RealmSwift


class Activity: Object{
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var link : String = ""
    @objc dynamic var des: String = ""
    @objc dynamic var category_id : Int = 0
    @objc dynamic var status : Int = 0
    @objc dynamic var used_count : Int = 0
    @objc dynamic var filePath : String = ""
    @objc dynamic var fileName : String = ""
    @objc dynamic var created : NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

