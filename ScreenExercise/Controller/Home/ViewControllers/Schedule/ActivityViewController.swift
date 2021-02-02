//
//  ActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-15.
//

import UIKit

class ActivityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
