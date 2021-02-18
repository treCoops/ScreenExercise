//
//  CreateActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit
import RealmSwift

class CreateActivityViewController: UIViewController  {

    @IBOutlet weak var txtActivityName: UITextField!
    @IBOutlet weak var txtActivityDescriptionCount: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtActivityNameCount: UILabel!
    
    var timeSlotID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtDescription.clipsToBounds = true
        txtDescription.layer.cornerRadius = 5
        txtDescription.contentInset.left = 5
        txtDescription.contentInset.right = 5
        
        txtDescription.delegate = self
        txtActivityName.delegate = self
        
        print(timeSlotID)

    }
    @IBAction func btnSavePressed(_ sender: UIButton) {
        
        if(Validator.isEmpty(txtActivityName.text ?? "")){
            AlertBar.danger(title: "Please enter activity name.")
            return
        }
        
        if(Validator.isEmpty(txtDescription.text ?? "")){
            AlertBar.danger(title: "Please enter activity description.")
            return
        }
        
        let customActivity = CustomActivity()
        customActivity.activityName = txtActivityName.text!
        customActivity.activityDescription = txtDescription.text!
        customActivity.childId = UserSession.getUserDefault(key: UserSessionKey.ACTIVED_CHILD_ID) ?? ""
        customActivity.timeSlotId = self.timeSlotID
        
        self.add(activity: customActivity)
        
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateActivityViewController : UITextFieldDelegate, UITextViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let length = ( txtActivityName.text!.count + string.count ) - range.length
        
        if (length > 20) {
            txtActivityNameCount.textColor = #colorLiteral(red: 0.9294117647, green: 0.4156862745, blue: 0.368627451, alpha: 1)
            return false
        }else {
            txtActivityNameCount.textColor = #colorLiteral(red: 0.6235294118, green: 0.6784313725, blue: 0.7215686275, alpha: 1)
        }
        
        txtActivityNameCount.text = "\(length)/20"
    
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       
        let length = ( txtDescription.text!.count + text.count ) - range.length

        if (length > 200) {
            txtActivityDescriptionCount.textColor = #colorLiteral(red: 0.9294117647, green: 0.4156862745, blue: 0.368627451, alpha: 1)
            return false
        }else {
            txtActivityDescriptionCount.textColor = #colorLiteral(red: 0.6235294118, green: 0.6784313725, blue: 0.7215686275, alpha: 1)
        }

        txtActivityDescriptionCount.text = "\(length)/200"
        
        return true
    }
}


extension CreateActivityViewController {
    func add(activity: CustomActivity){
        
        let realm = try! Realm()
        
        let eventResults = realm.objects(CustomActivity.self).filter("activityName contains[cd] %@ AND childId contains[cd] %@", activity.activityName, UserSession.getUserDefault(key: UserSessionKey.ACTIVED_CHILD_ID) ?? "")
        
        
        if (eventResults.count != 0) {
            AlertBar.warning(title: "This activity is already exists!")
        } else {
            try! realm.write{
                realm.add(activity)
                AlertBar.success(title: "Custom activity has been added!")
                self.updateTimeSlot(task: activity.activityName, activityID: activity.activityID)
            }
        }
            
    }
    
    
    func updateTimeSlot(task : String, activityID: String){
        let realm = try! Realm()
        
        let result = realm.objects(ChildTimeSlot.self).filter("timeID = %@ AND childID = %@", self.timeSlotID, UserSession.getUserDefault(key: UserSessionKey.ACTIVED_CHILD_ID) ?? "")
        
        if let timeSlot = result.first {
            try! realm.safeWrite {
                timeSlot.completeStatus = "Pending"
                timeSlot.isAssigned = true
                timeSlot.task = "Custom activity > \(task)"
                timeSlot.activityID = activityID
            }
        }
    }

}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}


