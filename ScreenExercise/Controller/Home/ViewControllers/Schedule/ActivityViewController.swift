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
        
        self.loadLottie(fileName: eventResults.first!.fileName)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.animationView.play(completion: { (finished) in
            print("playing")
        })
    }
    
    
    func loadLottie(fileName: String){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
           let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("ScreenExercise/\(fileName)") {
            let filePath = pathComponent.path
               let fileManager = FileManager.default
               if fileManager.fileExists(atPath: filePath) {
                    
                    print("FILE AVAILABLE")
                    animationView = .init(name: "abc")
                    let animation = Animation.filepath(filePath, animationCache: LRUAnimationCache.sharedCache)
                    print(animation?.framerate)
                    print(animation?.size)
                    animationView = AnimationView(animation: animation)
                    animationView.loopMode = .playOnce
                    animationView.contentMode = .scaleToFill
                    animationView.backgroundBehavior = .pauseAndRestore
                    self.animationView.play(completion: { (finished) in
                        print("playing")
                    })
                
               } else {
                   print("FILE NOT AVAILABLE")
               }
           } else {
               print("FILE PATH NOT AVAILABLE")
           }
    }
    
    
}
