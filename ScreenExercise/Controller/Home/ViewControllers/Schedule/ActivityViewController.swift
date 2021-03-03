//
//  ActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit
import Lottie
import RealmSwift


class ActivityViewController: UIViewController {
    
    @IBOutlet var animationView: AnimationView!
    @IBOutlet var txtActivityTitle: UILabel!
    @IBOutlet var txtActivityDescription: UILabel!
    
    
    var refDictionary = [String: Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getActivityData(id: self.refDictionary["activityID"] as! Int, categoryID: self.refDictionary["CategoryID"] as! Int, status: true)

    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getActivityData(id: Int, categoryID: Int, status: Bool){

        let realm = try! Realm()

        let eventResults = realm.objects(Activity.self).filter("id == \(id) AND category_id == \(categoryID)")
        
        if(status){
            txtActivityTitle.text = eventResults.first!.name
            txtActivityDescription.text = eventResults.first!.des

            self.loadLottie(fileName: eventResults.first!.fileName)
        }else{
            
            let category = realm.objects(Category.self).filter("id == \(categoryID)")
            
            updateTimeSlot(category: category.first!.name, activity: eventResults.first!.name, activityID: String(id))
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animationView!.play()
    }
    
    @IBAction func btnAddPressed(_ sender: UIButton) {
        self.getActivityData(id: self.refDictionary["activityID"] as! Int, categoryID: self.refDictionary["CategoryID"] as! Int, status: false)
        
    }
    
    func loadLottie(fileName: String){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
           let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("ScreenExercise/\(fileName)") {
            let filePath = pathComponent.path
               let fileManager = FileManager.default
               if fileManager.fileExists(atPath: filePath) {

                    print("FILE AVAILABLE")
                    let animation = Animation.filepath(filePath)
                    animationView.animation = animation
                    animationView.contentMode = .scaleToFill
                    animationView.backgroundBehavior = .pauseAndRestore
                    animationView!.loopMode = .loop
                    animationView!.animationSpeed = 1
                    animationView.play()

               } else {
                   print("FILE NOT AVAILABLE")
               }
           } else {
               print("FILE PATH NOT AVAILABLE")
           }
    }
}

extension ActivityViewController{
    func updateTimeSlot(category:String, activity : String, activityID: String){
        let realm = try! Realm()
        
        let result = realm.objects(ChildTimeSlot.self).filter("timeID = %@ AND childID = %@", self.refDictionary["timeSlotID"] ?? "", UserSession.getUserDefault(key: UserSessionKey.ACTIVED_CHILD_ID) ?? "")
        
        if let timeSlot = result.first {
            try! realm.safeWrite {
                timeSlot.completeStatus = "Pending"
                timeSlot.isAssigned = true
                timeSlot.task = "\(category) > \(activity)"
                timeSlot.activityID = activityID
            }
        }
    }
}
