//
//  ViewAssignedActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-03-01.
//

import UIKit
import RealmSwift

class ViewAssignedActivityViewController: UIViewController {
    
    @IBOutlet var txtActivityTitle: UILabel!
    @IBOutlet var txtActivityDescription: UILabel!
    
    var activity : Results<CustomActivity>!
    var customActivity : CustomActivity!
    
    var timeSlotID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fillForm()
        
        

    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRemovePressed(_ sender: UIButton) {
        do {
            let realm = try Realm()

            if let obj = realm.objects(CustomActivity.self).filter("timeSlotId = %@", timeSlotID).first {

                try! realm.write {
                    realm.delete(obj)
                }
            }
            
            let result = realm.objects(ChildTimeSlot.self).filter("timeID = %@", self.timeSlotID)
            
            if let timeSlot = result.first {
                try! realm.safeWrite {
                    timeSlot.completeStatus = "Not Scheduled"
                    timeSlot.isAssigned = false
                    timeSlot.task = ""
                }
            }
            
            if let act = realm.objects(ChildTimeSlot.self).filter("activityID = %@", PopupDialogViewController.id).first {
                try! realm.safeWrite {
                    act.isAssigned = false
                    act.task = ""
                }
            }
            
            self.navigationController?.popViewController(animated: true)
            
        } catch let error {
            print("error - \(error.localizedDescription)")
        }
    }
    
    func fillForm(){
        
        print(timeSlotID)
        
        let realm = try! Realm()
        activity = realm.objects(CustomActivity.self).filter("timeSlotId == %@", self.timeSlotID)
        
        print(activity)
        
//        customActivity = activity.first!
//
//        txtActivityTitle.text = customActivity.activityName
//        txtActivityDescription.text = customActivity.activityDescription
    }
    
}
