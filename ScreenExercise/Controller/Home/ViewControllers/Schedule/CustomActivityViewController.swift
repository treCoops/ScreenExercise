//
//  CustomActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit
import RealmSwift

class CustomActivityViewController: UIViewController {
    @IBOutlet weak var txtActivityName: UILabel!
    @IBOutlet weak var txtActivityDescription: UILabel!
    
    var activity : Results<CustomActivity>!
    var customActivity : CustomActivity!
    public var activityID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(activityID)
    }
    

    @IBAction func btnDeletePressed(_ sender: UIButton) {
        PopupDialogViewController.showPopup(parentVC: self, from: "DELETEACTIVITY>\(customActivity.activityID)")
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueEditCustomActivity", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fillForm()
    }
    
    func fillForm(){
        let realm = try! Realm()
        activity = realm.objects(CustomActivity.self).filter("activityID == %@", activityID)
        
        customActivity = activity.first!
        
        txtActivityName.text = customActivity.activityName
        txtActivityDescription.text = customActivity.activityDescription
        
    }
    
}

extension CustomActivityViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueEditCustomActivity" {
            (segue.destination as! EditActivityViewController).customActivity = customActivity
        }
    }
}
