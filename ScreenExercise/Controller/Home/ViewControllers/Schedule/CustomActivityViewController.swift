//
//  CustomActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit

class CustomActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnDeletePressed(_ sender: UIButton) {
        
        PopupDialogViewController.showPopup(parentVC: self, from: "DELETEACTIVITY")
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
