//
//  LaunchScreenViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-03-02.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet var txtLoadingStatus: UILabel!
    var apiHelper = APIHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiHelper.delagate = self

        apiHelper.getCategories()
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
