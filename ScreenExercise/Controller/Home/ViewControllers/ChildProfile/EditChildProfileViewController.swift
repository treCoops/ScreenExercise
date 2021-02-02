//
//  EditChildProfileViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit

class EditChildProfileViewController: UIViewController {

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

    @IBAction func onDeleteChildProfilePressed(_ sender: UIButton) {
        PopupDialogViewController.showPopup(parentVC: self, from: "EDITCHILD")
    }
    
}
