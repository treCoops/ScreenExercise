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
        "00:00 AM", "01:00 AM", "02:00 AM", "03:00 AM", "04:00 AM", "05:00 AM", "06:00 AM", "07:00 AM", "08:00 AM", "09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM",
        "01:00 PM", "02:00 PM", "03:00 PM", "04:00 PM", "05:00 PM", "06:00 PM", "07:00 PM", "08:00 PM", "09:00 PM", "10:00 PM", "11:00 PM"
    ]
    static var cmbInterval = [
        "5 minutes", "10 minutes", "15 minutes", "30 minutes", "45 minutes", "1 hour", "2 hours", "3 hours", "4 hours", "5 hours", "6 hours"
    ]
    
    static var cmbCategory = ["Eyes", "Head & Neck", "Hands & Fingers", "Legs", "Breathing", "Mind", "Physical & Interactive"]
}

struct UserSessionKey {
    static var KEY_VERIFICATION_ID = "KEY_VERIFICATION_ID"
    
    static var KEY_START_TIME = "KEY_START_TIME"
    static var KEY_END_TIME = "KEY_END_TIME"
    static var KEY_INTERVAL_TIME = "KEY_INTERVAL_TIME"
    
    static var START_TIME_INDEX = "START_TIME_INDEX"
    static var END_TIME_INDEX = "END_TIME_INDEX"
    static var INTERVAL_TIME_INDEX = "INTERVAL_TIME_INDEX"
    
    static var ACTIVED_CHILD_ID = "ACTIVED_CHILD_ID"
    
    static var USER_API_ID = "USER_API_ID"
    static var USER_LOGGED = "USER_LOGGED"
    
}
