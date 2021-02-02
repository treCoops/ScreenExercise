//
//  ScheduleViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-12.
//

import UIKit
import iOSDropDown

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var viewParent: CustomRoundedView!
    @IBOutlet weak var cmbType: DropDown!
    @IBOutlet weak var cmbStart: DropDown!
    @IBOutlet weak var cmbEnd: DropDown!
    @IBOutlet weak var cmbInterval: DropDown!
    @IBOutlet weak var tblSchedule: UITableView!
    
    let NManager = NotificationManager()
    let EHandler = EventHandler()
    
    
    var Schedules : [XIBSchedule] = []
    var newTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        EHandler.checkEventStoreAuthorizationStatus()
//        EHandler.createRemainder()
        
        NManager.requestPermission()
        NManager.showNotification(title: "This is test")
        
        cmbType.optionArray = DropdownArray.cmbType
        cmbStart.optionArray = DropdownArray.cmbTime
//        cmbEnd.optionArray = DropdownArray.cmbTime
        cmbInterval.optionArray = DropdownArray.cmbInterval
        
        cmbStart.didSelect{(selectedText , index ,id) in
                
            if(DropdownArray.cmbTime.firstIndex(of: selectedText) == 0){
                self.newTimeArray.removeAll()
                for item in DropdownArray.cmbTime {
                    if(item == selectedText){
                        continue
                    }
                    self.newTimeArray.append(item)
                }
                
            }else{
                self.newTimeArray.removeAll()
                var a : Int = DropdownArray.cmbTime.firstIndex(of: selectedText)! + 1
                while(a <= 23){
                    self.newTimeArray.append(DropdownArray.cmbTime[a])
                    a += 1
                }
                
                let b : Int = DropdownArray.cmbTime.firstIndex(of: selectedText)!
                var c : Int = 0
                while(c < b){
                   self.newTimeArray.append(DropdownArray.cmbTime[c])
                   c += 1
                }
            }
                    
                
            self.cmbEnd.optionArray = self.newTimeArray
        }
        
        tblSchedule.register(UINib(nibName: XIBIdentifier.XIB_SCHEDULE, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_SCHEDULE_CELL)
        
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        Schedules.append(XIBSchedule(dummy: "a"))
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
         performSegue(withIdentifier: "ScheduleActivityRowAddSegue", sender: self)
    }
}
