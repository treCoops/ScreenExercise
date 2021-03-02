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
        
        self.getActivityData(id: self.refDictionary["activityID"] as! Int, categoryID: self.refDictionary["CategoryID"] as! Int)

    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getActivityData(id: Int, categoryID: Int){

        let realm = try! Realm()

        let eventResults = realm.objects(Activity.self).filter("id == \(id) AND category_id == \(categoryID)")
        
        txtActivityTitle.text = eventResults.first!.name
        txtActivityDescription.text = eventResults.first!.des

        self.loadLottie(fileName: eventResults.first!.fileName)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animationView!.play()
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
