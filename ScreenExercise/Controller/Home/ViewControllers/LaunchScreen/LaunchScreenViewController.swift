//
//  LaunchScreenViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-03-02.
//

import UIKit
import Lottie


class LaunchScreenViewController: UIViewController {
    
    @IBOutlet var animationView: AnimationView!
    var apiHelper = APIHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.contentMode = .scaleToFill
//        animationView.backgroundBehavior = .pauseAndRestore
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        animationView.play()
//        animationView.alpha = 0;
        
        apiHelper.delagate = self

        apiHelper.getCategories()
        
        performSegue(withIdentifier: "SegueToLogin", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

extension LaunchScreenViewController : API {
    func refreshStatus(categoryCount: Int, activityCount: Int, activityLoadingCount: Int){
        
        print("C_Count: \(categoryCount) <> A_Count: \(activityCount) <> Loading Count: \(activityLoadingCount)")
        
    }
}
 
