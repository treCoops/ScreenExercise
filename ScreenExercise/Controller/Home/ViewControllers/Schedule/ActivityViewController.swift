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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getActivityData(id: 1, categoryID: 1)
        
    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getActivityData(id: Int, categoryID: Int){
        let realm = try! Realm()
        
        let eventResults = realm.objects(Activity.self).filter("id == \(id) AND category_id == \(categoryID)")
        
        print(eventResults.first!.filePath)
        
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = URL(fileURLWithPath: "eyes-left-right-up-down", relativeTo: directoryURL).appendingPathExtension("json")
        
        print(fileURL)
        
        let animation = Animation.filepath(fileURL.absoluteString, animationCache: LRUAnimationCache.sharedCache)
        animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        animationView.play()
    }
    
}
