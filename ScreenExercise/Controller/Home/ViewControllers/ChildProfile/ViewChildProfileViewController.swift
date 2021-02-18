//
//  ViewChildProfileViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit
import RealmSwift

class ViewChildProfileViewController: UIViewController {
    
    public var childID : String = ""
    var childProfiles : Results<ChildProfile>!
    public var child : ChildProfile!

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtAge: UILabel!
    @IBOutlet weak var txtGender: UILabel!
    @IBOutlet weak var txtTotalCompleted: UILabel!
    @IBOutlet weak var txtAddedDate: UILabel!
    @IBOutlet weak var btnActiveProfile: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.fillForm()
        self.checkForActiveOrNot()
    }
    
    func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    func fillForm(){
        let realm = try! Realm()
        childProfiles = realm.objects(ChildProfile.self).filter("childID == %@", childID)
        child = childProfiles.first!
        txtName.text = "\(child.childName)(\(child.childNickName))"
        txtAge.text = String(child.childAge)
        txtGender.text = child.childGender
        txtTotalCompleted.text = String(child.totalActivityCompleted)
        txtAddedDate.text = stringFromDate(child.created as Date)
    }
    
    @IBAction func btnEditPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueEditChildProfile", sender: self)
    }
    @IBAction func btnProfileActivedPressed(_ sender: Any) {
        let realm = try! Realm()
        
        let oldData = realm.objects(ChildProfile.self).filter("isActive = %@", true)
        
        if let childPro = oldData.first {
            try! realm.write {
                childPro.isActive = false
            }
        }
        
        let result = realm.objects(ChildProfile.self).filter("childID = %@", childID)
        
        if let childPro = result.first {
            try! realm.write {
                childPro.isActive = true
            }
        }
        
        self.checkForActiveOrNot()
        
        UserSession.setString(data: childID, key: UserSessionKey.ACTIVED_CHILD_ID)
        print(childID)
        
        AlertBar.success(title: "Child profile has been activated!")
    }
}

extension ViewChildProfileViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueEditChildProfile" {
            (segue.destination as! EditChildProfileViewController).childProfile = child
        }
    }
}

extension ViewChildProfileViewController {
    
    func checkForActiveOrNot(){
        let realm = try! Realm()
        let result = realm.objects(ChildProfile.self).filter("childID = %@", childID)
        if let child = result.first {
            if(child.isActive){
                btnActiveProfile.setTitle("Activated", for: .normal)
                btnActiveProfile.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.6784313725, blue: 0.7215686275, alpha: 1)
                btnActiveProfile.isEnabled = false
            }
        }
 
    }
   
}
