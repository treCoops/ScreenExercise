//
//  Constraints.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-12.
//

import Foundation

struct XIBIdentifier {
    static var XIB_SCHEDULE_CELL = "ReuseableCellSchedule"
    static var XIB_SCHEDULE = "ScheduleTableViewCell"
    
    static var XIB_CUSTOM_SCHEDULE_CELL = "ReuseableCellCustomSchedule"
    static var XIB_CUSTOM_SCHEDULE = "CustomScheduleTableViewCell"
    
    static var XIB_CHILD_PROFILE_CELL = "ReuseableCellChildProfile"
    static var XIB_CHILD_PROFILE = "ChildProfileTableViewCell"
    
    static var XIB_LEADERBOARD_CELL = "ReuseableCellLeaderboard"
    static var XIB_LEADERBOARD = "LeaderboardTableViewCell"
    
    static var XIB_CATEGORY = "XIBCategory"
    static var XIB_CATEGORY_CELL = "CategoryReuseableCell"
    static var NIB_NAME_CATEGORY_CLASS = "CategoryCollectionViewCell"
    
    
    static var XIB_CATEGORY_TWO = "XIBCategoryTwo"
    static var XIB_CATEGORY_CELL_TWO = "CategoryReuseableCellTwo"
    static var NIB_NAME_CATEGORY_CLASS_TWO = "CategoryTwoCollectionViewCell"
    
}

struct DropdownArray {
    static var cmbType = ["All", "Upcoming", "Completed", "Incompleted", "Not Scheduled"]
    static var cmbTime = [
        "00:00AM", "01:00AM", "02:00AM", "03:00AM", "04:00AM", "05:00AM", "06:00AM", "07:00AM", "08:00AM", "09:00AM", "10:00AM", "11:00AM", "12:00PM",
        "01:00PM", "02:00PM", "03:00PM", "04:00PM", "05:00PM", "06:00PM", "07:00PM", "08:00PM", "09:00PM", "10:00PM", "11:00PM"
    ]
    static var cmbInterval = [
        "30 minutes", "45 minutes", "1 hour", "2 hours", "3 hours", "4 hours", "5 hours", "6 hours"
    ]
    
    static var cmbCategory = ["Eyes", "Head & Neck", "Hands & Fingers", "Legs", "Breathing", "Mind", "Physical & Interactive"]
}
