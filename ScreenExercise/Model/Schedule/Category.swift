//
//  Category.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-24.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var comments : String = ""
    @objc dynamic var image : String = ""
    @objc dynamic var type : Int = 00
    
//    @objc dynamic var taskPending : Int = 0
//    @objc dynamic var taskCompleted : Int = 0
//    @objc dynamic var taskIncompleted : Int = 0
//    @objc dynamic var isActive : Bool = false
//    @objc dynamic var totalActivityCompleted : Int = 10
//    @objc dynamic var profileImage: NSData = NSData()
    @objc dynamic var created : NSDate = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
