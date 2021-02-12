//
//  PopupDialogViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit
import RealmSwift

class PopupDialogViewController: UIViewController {
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    static var from : String = ""
    static var id : String = ""
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if(sender.tag == 1){
            if(PopupDialogViewController.from == "EDITCHILD"){
                do {
                    let realm = try Realm()

                    if let obj = realm.objects(ChildProfile.self).filter("childID = %@", PopupDialogViewController.id).first {

                        try! realm.write {
                            realm.delete(obj)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }

                } catch let error {
                    print("error - \(error.localizedDescription)")
                }
            }
        }else if(sender.tag == 2){
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        
        if(PopupDialogViewController.from == "EDITCHILD"){
            txtTitle.text = "Delete Child Profile"
            txtDescription.text = "Are you sure you want to delete the Erin Calzoni’s child profile?"
            
        }
        
        if(PopupDialogViewController.from == "DELETEACTIVITY"){
            txtTitle.text = "Delete Custom Activity"
            txtDescription.text = "Are you sure you want to delete the activity Washing Hands?"
        }
    }
    
    static func showPopup(parentVC: UIViewController, from: String){
        
        let words = from.components(separatedBy: [">"]).filter({!$0.isEmpty})
        
        self.from = words[0]
        self.id = words[1]

        if let popupViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "PopupDialogViewController") as? PopupDialogViewController {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            parentVC.present(popupViewController, animated: true)
        }
      }
}
