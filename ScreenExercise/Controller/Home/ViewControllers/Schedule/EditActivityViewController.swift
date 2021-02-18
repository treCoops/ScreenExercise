//
//  EditActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit
import RealmSwift

class EditActivityViewController: UIViewController {

    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtActivityName: UITextField!
    public var customActivity : CustomActivity!
    @IBOutlet weak var txtActivityTextCount: UILabel!
    @IBOutlet weak var txtActivityDescriptionTextCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillForm(activity: customActivity)
        
        txtDescription.clipsToBounds = true;
        txtDescription.layer.cornerRadius = 5;

        txtDescription.contentInset.left = 5
        txtDescription.contentInset.right = 5
        
        txtDescription.delegate = self
        txtActivityName.delegate = self

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
        
        let activity = CustomActivity()
        activity.activityName = txtActivityName.text ?? ""
        activity.activityDescription = txtDescription.text ?? ""
        
        self.updateCustomActivity(activity: activity)
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditActivityViewController : UITextFieldDelegate, UITextViewDelegate{
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
            txtActivityTextCount.textColor = #colorLiteral(red: 0.9294117647, green: 0.4156862745, blue: 0.368627451, alpha: 1)
            return false
        }else {
            txtActivityTextCount.textColor = #colorLiteral(red: 0.6235294118, green: 0.6784313725, blue: 0.7215686275, alpha: 1)
        }
        
        txtActivityTextCount.text = "\(length)/20"
    
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       
        let length = ( txtDescription.text!.count + text.count ) - range.length

        if (length > 200) {
            txtActivityDescriptionTextCount.textColor = #colorLiteral(red: 0.9294117647, green: 0.4156862745, blue: 0.368627451, alpha: 1)
            return false
        }else {
            txtActivityDescriptionTextCount.textColor = #colorLiteral(red: 0.6235294118, green: 0.6784313725, blue: 0.7215686275, alpha: 1)
        }

        txtActivityDescriptionTextCount.text = "\(length)/200"
        
        return true
    }
}


extension EditActivityViewController{
    func fillForm(activity: CustomActivity){
        txtDescription.text = activity.activityDescription
        txtActivityName.text = activity.activityName
    }
    
    func updateCustomActivity(activity: CustomActivity){
        let realm = try! Realm()
        
        let result = realm.objects(CustomActivity.self).filter("activityID = %@", customActivity.activityID)
        
        if let act = result.first {
            try! realm.write {
                act.activityName = activity.activityName
                act.activityDescription = activity.activityDescription
            }
            self.updateTimeSlotRecord(task: activity.activityName)
            AlertBar.success(title: "Custom activity has been updated!")
        }
    }
    
    func updateTimeSlotRecord(task: String){
        let realm = try! Realm()
        
        let result = realm.objects(ChildTimeSlot.self).filter("activityID = %@", customActivity.activityID)
        
        if let act = result.first {
            try! realm.safeWrite {
                act.task = task
            }
        }
    }
}
