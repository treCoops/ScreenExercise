//
//  AddChildProfileViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-01-27.
//

import UIKit
import DLRadioButton

class AddChildProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func rdnRadioButtonSelected(_ sender: DLRadioButton) {
        
        
        
    }
}
