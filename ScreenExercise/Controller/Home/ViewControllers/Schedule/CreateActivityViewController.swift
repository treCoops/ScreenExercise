//
//  CreateActivityViewController.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-02.
//

import UIKit

class CreateActivityViewController: UIViewController {

    @IBOutlet weak var txtDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        txtDescription.clipsToBounds = true;
        txtDescription.layer.cornerRadius = 5;

    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
