//
//  ScheduleViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-12.
//

import UIKit
import iOSDropDown
import RealmSwift

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var viewParent: CustomRoundedView!
    @IBOutlet weak var cmbType: DropDown!
    @IBOutlet weak var cmbStart: DropDown!
    @IBOutlet weak var cmbEnd: DropDown!
    @IBOutlet weak var cmbInterval: DropDown!
    @IBOutlet weak var tblSchedule: UITableView!
    
    var alert : UIAlertController!
    
    let NManager = NotificationManager()
    let EHandler = EventHandler()
    
    
    var Schedules : [XIBSchedule] = []
    var newTimeArray = [String]()
    var intvalTimeArray = [String]()
    
    var selectedTime : String = ""
    var flag : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        EHandler.checkEventStoreAuthorizationStatus()
//        EHandler.createRemainder()
        
        createAlertDialog()
        
//        self.checkChildProfileExistsAndActived()
        
        
        NManager.requestPermission()
        NManager.showNotification(title: "This is test")
        
        cmbType.optionArray = DropdownArray.cmbType
        cmbStart.optionArray = DropdownArray.cmbTime
        
        self.autoFill()
        
        cmbStart.didSelect{(selectedText , index ,id) in
            
            self.clearTableCustomActivity()
            
            
            if(UserSession.getUserDefault(key: UserSessionKey.KEY_START_TIME) != nil){
                self.flag = true
            }
            
            if(self.flag){
                self.cmbEnd.select(0)
            }
            self.flag = true
            
            UserSession.setString(data: selectedText, key: UserSessionKey.KEY_START_TIME)
            UserSession.setInt(data: index, key: UserSessionKey.START_TIME_INDEX)
            
            
            self.newTimeArray.removeAll()
            
            self.newTimeArray = TimeValidator.getEndTimeArray(selectedText: selectedText)
                                    
            self.cmbEnd.optionArray = self.newTimeArray
            
        }
        
        
        cmbEnd.didSelect{(selectedText, index, id) in
            
            self.clearTableCustomActivity()

            self.intvalTimeArray.removeAll()
            
            self.selectedTime = selectedText
        
            self.cmbInterval.optionArray = TimeValidator.createdIntervals(diff: TimeValidator.getTimeDiff(time1Str: DropdownArray.cmbTime[self.cmbStart.selectedIndex ?? 0], time2Str: self.newTimeArray[index]))
            
            UserSession.setString(data: selectedText, key: UserSessionKey.KEY_END_TIME)
            
            if(self.cmbInterval.selectedIndex != nil){
                
                if(self.cmbStart.selectedIndex != nil){
                    self.updateArray(timeSlots: TimeValidator.getTimeIntervaleSlots(startTime: DropdownArray.cmbTime[self.cmbStart.selectedIndex!], endTime: self.selectedTime, interval: DropdownArray.cmbInterval[self.cmbInterval.selectedIndex!]), isAutoLoad: false)
                }else{
                    self.updateArray(timeSlots: TimeValidator.getTimeIntervaleSlots(startTime: UserSession.getUserDefault(key: UserSessionKey.KEY_START_TIME)!, endTime: self.selectedTime, interval: DropdownArray.cmbInterval[self.cmbInterval.selectedIndex!]), isAutoLoad: false)
                }
            }
            
        }
        
        cmbInterval.didSelect{(selectedText, index, id) in
            UserSession.setString(data: selectedText, key: UserSessionKey.KEY_INTERVAL_TIME)
            self.clearTableCustomActivity()
            
            if(self.cmbStart.selectedIndex != nil || self.cmbEnd.selectedIndex != nil){
                self.updateArray(timeSlots:TimeValidator.getTimeIntervaleSlots(startTime: DropdownArray.cmbTime[self.cmbStart.selectedIndex ?? UserSession.getInt(key: UserSessionKey.START_TIME_INDEX)], endTime: self.selectedTime, interval: DropdownArray.cmbInterval[self.cmbInterval.selectedIndex!]), isAutoLoad: false)
            }else {
                self.updateArray(timeSlots:TimeValidator.getTimeIntervaleSlots(startTime: UserSession.getUserDefault(key: UserSessionKey.KEY_START_TIME)!, endTime: UserSession.getUserDefault(key: UserSessionKey.KEY_END_TIME)!, interval: UserSession.getUserDefault(key: UserSessionKey.KEY_INTERVAL_TIME)!), isAutoLoad: false)
            }
        }
        
        
        tblSchedule.register(UINib(nibName: XIBIdentifier.XIB_SCHEDULE, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_SCHEDULE_CELL)
        
    }
    
    func checkChildProfileExistsAndActived(){
        let realm = try! Realm()
        if(realm.objects(ChildProfile.self).count == 0){
            self.present(alert, animated: true)
        }
        
    }
    
    func createAlertDialog() {
        alert = UIAlertController(title: "Screen Exersice", message: "Pleasse create a child before continue", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {_ in
            if let tabBarController = self.navigationController?.tabBarController  {
                    tabBarController.selectedIndex = 2
                }
        }))
    
    }
    
    func updateArray(timeSlots : [String], isAutoLoad: Bool){
        
        Schedules.removeAll()
        
        let realm = try! Realm()
        
        if(isAutoLoad){
            feedTable()
        }else{
            
            self.clearTableTimeSlot()
            
            for time in timeSlots {
                let timeSlot = ChildTimeSlot()
                
                timeSlot.childID = UserSession.getUserDefault(key: UserSessionKey.ACTIVED_CHILD_ID) ?? ""
                timeSlot.completeStatus = ""
                timeSlot.imgRef = ""
                timeSlot.isAssigned = false
                timeSlot.time = time
                timeSlot.task = ""
                
                try! realm.write{
                    realm.add(timeSlot)
                }
            }
            
            feedTable()
        }
        
        tblSchedule.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.autoFill()
        tblSchedule.reloadData()
        self.checkChildProfileExistsAndActived()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

extension ScheduleViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSchedule.dequeueReusableCell(withIdentifier: XIBIdentifier.XIB_SCHEDULE_CELL, for: indexPath) as! ScheduleTableViewCell
               cell.configXIB(data: Schedules[indexPath.row])
               
               cell.alpha = 0
               UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                   cell.alpha = 1
               })
        
        let clearView = UIView()
        UIView().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectedBackgroundView = clearView
               
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(Schedules[indexPath.row].isAssigned){
            performSegue(withIdentifier: "SeagueViewAssignedTask", sender: self)
        }else{
            performSegue(withIdentifier: "ScheduleActivityRowAddSegue", sender: self)
        }
        
         
    }
}

extension ScheduleViewController {
    
    func clearTableTimeSlot(){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(ChildTimeSlot.self))
        }
    }
    
    func clearTableCustomActivity(){
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(CustomActivity.self))
        }
    }
    
    func feedTable(){
        let realm = try! Realm()
        let timeSlots = realm.objects(ChildTimeSlot.self).filter("childID = %@", UserSession.getUserDefault(key: UserSessionKey.ACTIVED_CHILD_ID) ?? "").sorted(byKeyPath: "created", ascending: true)
        
        if(!timeSlots.isEmpty){
            for times in timeSlots {
                Schedules.append(XIBSchedule(childID: times.childID, timeSlotId: times.timeID, completeStatus: times.completeStatus, time: times.time, isAssigned: times.isAssigned, task: times.task, imgRef: times.imgRef))
            }
        }
    }
    
    func autoFill(){
        if(UserSession.getUserDefault(key: UserSessionKey.KEY_START_TIME) != nil){
            cmbStart.text = UserSession.getUserDefault(key: UserSessionKey.KEY_START_TIME)
            UserSession.setInt(data: DropdownArray.cmbTime.firstIndex(of: UserSession.getString(key: UserSessionKey.KEY_START_TIME)) ?? 0, key: UserSessionKey.START_TIME_INDEX)
            
            self.newTimeArray.removeAll()
            
            self.newTimeArray = TimeValidator.getEndTimeArray(selectedText: UserSession.getString(key: UserSessionKey.KEY_START_TIME))

            self.cmbEnd.optionArray = self.newTimeArray
            
            if(UserSession.getUserDefault(key: UserSessionKey.KEY_END_TIME) != nil){
                cmbEnd.text = UserSession.getUserDefault(key: UserSessionKey.KEY_END_TIME)
                UserSession.setInt(data: DropdownArray.cmbTime.firstIndex(of: UserSession.getString(key: UserSessionKey.KEY_END_TIME)) ?? 0, key: UserSessionKey.END_TIME_INDEX)
                
                self.intvalTimeArray.removeAll()
                
                self.cmbInterval.optionArray = TimeValidator.createdIntervals(diff: TimeValidator.getTimeDiff(time1Str: UserSession.getUserDefault(key: UserSessionKey.KEY_START_TIME)!, time2Str:  UserSession.getUserDefault(key: UserSessionKey.KEY_END_TIME)!))
                
                cmbInterval.text = UserSession.getUserDefault(key: UserSessionKey.KEY_INTERVAL_TIME)
                
                if(UserSession.getUserDefault(key: UserSessionKey.KEY_INTERVAL_TIME) != nil){
                    self.updateArray(timeSlots: TimeValidator.getTimeIntervaleSlots(startTime: UserSession.getUserDefault(key: UserSessionKey.KEY_START_TIME)!, endTime:UserSession.getUserDefault(key: UserSessionKey.KEY_END_TIME)!, interval: UserSession.getUserDefault(key: UserSessionKey.KEY_INTERVAL_TIME)!), isAutoLoad: true)
                }
            }
        }
    }
}

extension ScheduleViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScheduleActivityRowAddSegue" {

            if let indexPath = self.tblSchedule.indexPathForSelectedRow {
                (segue.destination as! SelectActivityViewController).timeSlotID = Schedules[indexPath.row].timeSlotId
            }
        }
        
        if segue.identifier == "SeagueViewAssignedTask" {

            if let indexPath = self.tblSchedule.indexPathForSelectedRow {
                (segue.destination as! ViewAssignedActivityViewController).timeSlotID = Schedules[indexPath.row].timeSlotId
            }
        }
    }
}




